package com.synapseos.backend.services

import org.scalatest.funsuite.AnyFunSuite
import com.synapseos.backend.models.UserRegister

class AuthServiceTest extends AnyFunSuite {
  val authService = new AuthService("test_secret", 3600L)

  test("AuthService should register a new user successfully") {
    val reg = UserRegister("testuser", "test@example.com", "password123")
    val result = authService.register(reg)
    assert(result.isRight)
  }

  test("AuthService should fail to register existing user") {
    val reg = UserRegister("testuser", "test@example.com", "password123")
    authService.register(reg) // First attempt
    val result = authService.register(reg) // Second attempt
    assert(result.isLeft)
    assert(result.left.get == "Username already exists")
  }

  test("AuthService should validate a generated token") {
    val reg = UserRegister("validuser", "valid@example.com", "password")
    val token = authService.register(reg).toOption.get
    val userId = authService.validateToken(token.token)
    assert(userId.isDefined)
  }
}
