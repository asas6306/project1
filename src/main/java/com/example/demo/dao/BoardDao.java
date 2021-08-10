package com.example.demo.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.demo.dto.Auth;
import com.example.demo.dto.Board;

@Mapper
public interface BoardDao {
	public List<Board> getAllBoardInfo(@Param(value="boardType") String boardType);
	public List<Board> getBoardCnt(@Param(value="boardType") String boardType);
}
