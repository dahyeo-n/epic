package me.jdh.epic.user.service.impl;

import java.util.UUID;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import me.jdh.epic.user.dto.SignUpRequstDto;
import me.jdh.epic.user.exception.DuplicateEmailException;
import me.jdh.epic.user.mapper.UserMapper;
import me.jdh.epic.user.service.UserService;
import me.jdh.epic.user.vo.User;

@Service
public class UserServiceImpl implements UserService {

  private final UserMapper userMapper; 

  public UserServiceImpl(UserMapper userMapper) {
    this.userMapper = userMapper;
  }

  @Override
  @Transactional
  public int signUp(SignUpRequstDto dto) throws Exception {
    System.out.println("[Service] signUp - dto: " + dto);

    boolean existedEmail = userMapper.existByEmail(dto.getEmail());
    System.out.println("[Service] signUp - existedEmail: " + existedEmail);

    if (existedEmail) {
      throw new DuplicateEmailException();
    }

    String encryptedPassword = encryptPassword(dto.getPassword());
    System.out.println("[Service] signUp - encryptedPassword: " + encryptedPassword);

    User user = new User(
      null,
      UUID.randomUUID().toString(),
      "USER",
      "ACTIVE",
      dto.getEmail(),
      encryptedPassword,
      dto.getNickname(),
      dto.getDescription(),
      dto.getImageUrl(),
      null,
      null
    );

    System.out.println("[Service] signUp - user: " + user);

    int result = userMapper.save(user);
    System.out.println("[Service] signUp - result: " + result);

    return result;
  }

  private String encryptPassword(String password) {
    // TODO 비밀번호 암호화 로직 구현
    return password;
  }

}
