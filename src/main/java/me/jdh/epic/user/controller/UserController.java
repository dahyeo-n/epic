package me.jdh.epic.user.controller;

import javax.validation.Valid;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import me.jdh.epic.user.dto.SignUpRequstDto;
import me.jdh.epic.user.service.UserService;

@Controller
@RequestMapping("/users")
public class UserController {

  private final UserService userService;

  public UserController(UserService userService) {
    this.userService = userService;
  }

  @PostMapping("/signup.do")
  public ResponseEntity<Integer> signUp(@RequestBody @Valid SignUpRequstDto dto) throws Exception {
    System.out.println("[Controller] signUp - dto: " + dto);
    int result = userService.signUp(dto);
    System.out.println("[Controller] signUp - result: " + result);
    return ResponseEntity.status(HttpStatus.CREATED).body(result);
  }

}
