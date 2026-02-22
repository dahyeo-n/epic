package me.jdh.epic.user.dto;

import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;

public class SignUpRequstDto {

  @NotNull
  private String email;

  @NotNull
  @Pattern(
    regexp = "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[,.!?])[A-Za-z0-9,.!?]{10,}$",
    message = "Password must be at least 10 characters and include at least one letter, one digit, and one special character (,.!?)"
  )
  private String password;

  @NotNull
  private String nickname;

  private String description;

  private String imageUrl;

  public SignUpRequstDto() {}

  public SignUpRequstDto(String email, String password, String nickname, String description, String imageUrl) {
    this.email = email;
    this.password = password;
    this.nickname = nickname;
    this.description = description;
    this.imageUrl = imageUrl;
  }

  public String getEmail() {
    return email;
  }

  public String getPassword() {
    return password;
  }

  public String getNickname() {
    return nickname;
  }

  public String getDescription() {
    return description;
  }

  public String getImageUrl() {
    return imageUrl;
  }

  @Override
  public String toString() {
    return "SignUpRequstDto [email=" + email + ", password=" + password + ", nickname=" + nickname + ", description=" + description + ", imageUrl=" + imageUrl + "]";
  }

}
