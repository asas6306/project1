package com.example.demo.dao;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.example.demo.dto.Member;

@Mapper
public interface MemberDao {

	public Member login(@Param(value="ID") String ID);

}
