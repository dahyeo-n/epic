package me.jdh.epic.user.vo;

import java.time.LocalDateTime;

public class User {
  
  private Integer userNo;

  private String userId;

  private String role;

  private String status;

  private String email;

  private String password;

  private String nickname;

  private String description;

  private String imageUrl;

  private LocalDateTime createdAt;

  private LocalDateTime updatedAt;

  public User(Integer userNo, String userId, String role, String status, String email, String password, String nickname, String description, String imageUrl, LocalDateTime createdAt, LocalDateTime updatedAt) {
    this.userNo = userNo;
    this.userId = userId;
    this.role = role;
    this.status = status;
    this.email = email;
    this.password = password;
    this.nickname = nickname;
    this.description = description;
    this.imageUrl = imageUrl;
    this.createdAt = createdAt;
    this.updatedAt = updatedAt;
  }

  public int getUserNo() {
    return userNo;
  }

  public void setUserNo(int userNo) {
    this.userNo = userNo;
  }

  public String getUserId() {
    return userId;
  }

  public void setUserId(String userId) {
    this.userId = userId;
  }

  public String getRole() {
    return role;
  }

  public void setRole(String role) {
    this.role = role;
  }

  public String getStatus() {
    return status;
  }

  public void setStatus(String status) {
    this.status = status;
  }

  public String getEmail() {
    return email;
  }

  public void setEmail(String email) {
    this.email = email;
  }

  public String getPassword() {
    return password;
  }

  public void setPassword(String password) {
    this.password = password;
  }

  public String getNickname() {
    return nickname;
  }

  public void setNickname(String nickname) {
    this.nickname = nickname;
  }

  public String getDescription() {
    return description;
  }

  public void setDescription(String description) {
    this.description = description;
  }

  public String getImageUrl() {
    return imageUrl;
  }

  public void setImageUrl(String imageUrl) {
    this.imageUrl = imageUrl;
  }

  public LocalDateTime getCreatedAt() {
    return createdAt;
  }

  public void setCreatedAt(LocalDateTime createdAt) {
    this.createdAt = createdAt;
  }

  public LocalDateTime getUpdatedAt() {
    return updatedAt;
  }

  public void setUpdatedAt(LocalDateTime updatedAt) {
    this.updatedAt = updatedAt;
  }

  @Override
  public String toString() {
    return "User [userNo=" + userNo + ", userId=" + userId + ", role=" + role + ", status=" + status + ", email=" + email + ", password=" + password + ", nickname=" + nickname + ", description=" + description + ", imageUrl=" + imageUrl + ", createdAt=" + createdAt + ", updatedAt=" + updatedAt + "]";
  }
}
