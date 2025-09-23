import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wisp/core/config/di/injection.dart';
import 'package:wisp/domain/entities/auth/signup_entity.dart';
import 'package:wisp/domain/usecases/auth/signup_usecase.dart';
import 'package:wisp/presentation/auth/state/signup_state.dart';

final signUpControllerProvider =
    StateNotifierProvider<SignupController, SignupState>((ref) {
      final signUpUseCase = getIt<SignUpUsecase>();
      return SignupController(signUpUseCase);
    });

class SignupController extends StateNotifier<SignupState> {
  final SignUpUsecase signUpUseCase;

  SignupController(this.signUpUseCase) : super(SignupState());

  Future<void> signUp(SignUpEntity entity) async {
    state = state.copyWith(isLoading: true, errorMessage: '');
    try {
      await signUpUseCase.signUp(entity);
    } catch (e) {
      state = state.copyWith(errorMessage: '회원가입에 실패했습니다: $e');
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> sendSms(String phoneNumber) async {
    if (!isValidPhoneNumber(phoneNumber)) {
      state = state.copyWith(errorMessage: '올바른 전화번호를 입력해주세요.');
      return;
    }

    state = state.copyWith(isLoading: true, errorMessage: '');

    try {
      await signUpUseCase.sendSms(phoneNumber);
      state = state.copyWith(isPhoneNumber: true);
    } catch (e) {
      state = state.copyWith(errorMessage: 'SMS 전송에 실패했습니다: $e');
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> verify(String smsCode) async {
    state = state.copyWith(isLoading: true, errorMessage: '');

    try {
      await signUpUseCase.verifySms(smsCode);
      state = state.copyWith(isVerify: true);
    } catch (e) {
      state = state.copyWith(errorMessage: 'SMS 인증에 실패했습니다: $e');
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  bool isValidPhoneNumber(String phoneNumber) {
    return RegExp(r'^010\d{8}$').hasMatch(phoneNumber);
  }

  bool isValidPassword(String password) {
    return password.length >= 8;
  }

  bool isPasswordMatch(String password, String confirmPassword) {
    return password == confirmPassword;
  }

  void clearError() {
    state = state.copyWith(errorMessage: '');
  }
}
