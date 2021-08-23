package com.example.demo.dao;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface NoteDao {

	public void send(@Param(value="sUid") int sUid, @Param(value="rUid") int rUid, @Param(value="body") String body);
}
