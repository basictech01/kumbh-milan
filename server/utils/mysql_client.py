# type: ignore


import logging
from typing import Optional

from mysql.connector import pooling

from .config import MYSQL

log = logging.getLogger("mysql_client")


pool = pooling.MySQLConnectionPool(
    pool_name="mypool",
    pool_size=10,
    pool_reset_session=True,
    host=MYSQL["host"],
    user=MYSQL["user"],
    password=MYSQL["password"],
    database=MYSQL["database"],
    port=MYSQL["port"],
)


class MySQLConnection:
    connection: Optional[pooling.PooledMySQLConnection] = None

    def __enter__(self):
        """
        Enter the context manager and establish a connection.
        """
        self.connection = pool.get_connection()
        return self

    def __exit__(self, exc_type, exc_val, exc_tb):
        """
        Exit the context manager and close the connection.
        """
        self.close()
        # Handle exceptions, if any
        if exc_type:
            log.error(f"Error occurred: {exc_val}")
        return False  # Re-raises any exception that occurred

    def __del__(self):
        self.close()

    def close(self):
        """
        Close the MySQL connection.
        """
        if self.connection:
            self.connection.close()
            self.connection = None

    def ping(self, reconnect=False) -> bool:
        """
        Function to ping MySQL server
        """
        if not self.connection:
            raise Exception("Connection not established please call connect() first")
        try:
            self.connection.ping(reconnect=reconnect, attempts=3, delay=1)
            return True
        except Exception as err:
            log.error(f"Error pinging MySQL server: {err}")
            return False

    def read(self, query: str, *args: list) -> list[dict]:
        if not self.connection:
            return []
        cur = self.connection.cursor(dictionary=True)
        try:
            cur.execute(query, args)
            return cur.fetchall()
        except Exception as err:
            log.error(f"Error running sql '{cur.statement}': {err}")
            raise err

    def write(self, query: str, *args: list) -> int:
        """
        Function to execute non-SELECT queries (INSERT, UPDATE, DELETE, etc.) to MySQL
        """
        cur = self.connection.cursor(dictionary=True)
        try:
            cur.execute(query, args)
            self.connection.commit()
            return cur.lastrowid
        except Exception as err:
            log.error(f"Error running sql '{cur.statement}': {err}")
            raise err

    def read_one(self, query: str, *args: list) -> list[dict]:
        cur = self.connection.cursor(dictionary=True)
        try:
            cur.execute(query, args)
            return cur.fetchone()
        except Exception as err:
            log.error(f"Error running sql '{cur.statement}': {err}")
            raise err
