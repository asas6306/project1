package com.example.demo.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.demo.dto.Auth;

@Mapper
public interface AuthDao {

	public List<Auth> getAuths();
}
