package me.jdh.epic.user.mapper;

import org.apache.ibatis.annotations.Mapper;

import me.jdh.epic.user.vo.User;

@Mapper
public interface UserMapper {
  
  boolean existByEmail(String email);

  int save(User user);
}
