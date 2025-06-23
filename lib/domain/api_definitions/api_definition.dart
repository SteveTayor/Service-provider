import 'package:bundlegram/data/datasources/remote/endpoints.dart';
import 'package:bundlegram/data/models/auth/auth_model.dart';
import 'package:bundlegram/data/models/auth/login/login_response.dart';
import 'package:bundlegram/data/models/auth/registeration/registeration_response.dart';
import 'package:bundlegram/data/models/auth/registeration/username/username_response.dart';
import 'package:bundlegram/data/models/auth/wallet/get_wallet_response.dart';
import 'package:bundlegram/data/models/profile/profile_response.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'api_definition.g.dart';

@RestApi(baseUrl: Endpoints.baseUrl)
abstract class ApiDefinition {
  factory ApiDefinition(Dio dio, {String baseUrl}) = _ApiDefinition;
  static const _authHeader = "Authorization";

  // Authentication
  @POST(Endpoints.register)
  Future<RegisterResponse> register(
    @Body() RegisterRequest body,
  );

  @POST(Endpoints.login)
  Future<LoginResponse> login(
    @Body() LoginRequest body,
  );

  @POST(Endpoints.logout)
  Future<void> logout(
    @Header(_authHeader) String bearer,
  );

  // Username endpoints
  @POST(Endpoints.checkUsername)
  Future<UsernameResponse> checkUsername(
    @Body() CheckUsernameRequest body,
  );

  @POST(Endpoints.addUsername)
  Future<UsernameResponse> addUsername(
    @Header(_authHeader) String bearer,
    @Body() AddUsernameRequest body,
  );

  // Profile & Wallet (loaded before dashboard)
  @GET(Endpoints.userProfile)
  Future<ProfileResponse> getProfile(
    @Header(_authHeader) String bearer,
  );

  @GET(Endpoints.wallet)
  Future<GetWalletResponse> getWallet(
    @Header(_authHeader) String bearer,
  );

  // … add the rest of your endpoints in similar fashion …
}
