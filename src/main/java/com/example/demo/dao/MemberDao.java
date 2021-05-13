package com.example.demo.dao;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.example.demo.dto.Member;
import com.example.demo.util.ResultData;

@Mapper
public interface MemberDao {

	public Member login(@Param(value = "ID") String ID);

	public void signup(Map<String, Object> param);

	public Member getMember(@Param(value = "type") String type, @Param(value = "itemValue") String itemValue);

	public void update(Map<String, Object> param);
}
