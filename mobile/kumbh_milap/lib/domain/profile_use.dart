import '../core/model/profile_model.dart';
import '../data/profile_repository.dart';

class ProfileUseCase {
  final ProfileRepository repository;

  ProfileUseCase(this.repository);

  Future<int> createProfile(ProfileModel profile) async {
    return await repository.createProfile(profile);
  }

  Future<Map<String, dynamic>> getProfile() async {
    return await repository.getProfile();
  }

  Future<String?> uploadProfilePhoto(String imagePath) async {
    return await repository.uploadProfilePhoto(imagePath);
  }

  Future<int> updateProfile(Map<String, dynamic> profile) async {
    return await repository.updateProfile(profile);
  }
}
