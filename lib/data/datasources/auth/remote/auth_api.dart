import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:wisp/data/models/auth/request/signin_request_dto.dart';
import 'package:wisp/data/models/auth/request/signup_request_dto.dart';
import 'package:wisp/data/models/auth/response/refresh_token_response_dto.dart';

part 'auth_api.g.dart';

@RestApi()
abstract class AuthApi {
  factory AuthApi(Dio dio, {String baseUrl}) = _AuthApi;

  @POST('/auth/send-sms')
  Future<void> sendSms(
    @Body() Map<String, dynamic> body,
  );

  @PATCH('/auth/verify-phone')
  Future<void> verifyPhone(
    @Body() Map<String, dynamic> body,
  );

  @POST('/auth/signup')
  Future<void> signUp(
    @Body() SignUpRequestDto body,
  );

  @POST('/auth/signin')
  Future<void> signIn(
    @Body() SigninRequestDto body,
  );

  @PATCH('/auth/change-password')
  Future<void> changePassword(
    @Body() Map<String, dynamic> body,
  );

  @PUT('/auth/refresh-token')
  Future<RefreshTokenResponseDto> refreshToken(
    @Body() Map<String, dynamic> body,
  );
}
