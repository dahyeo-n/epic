package me.jdh.epic.user.service;

import me.jdh.epic.user.dto.SignUpRequstDto;

public interface UserService {

  int signUp(SignUpRequstDto dto) throws Exception;

}
