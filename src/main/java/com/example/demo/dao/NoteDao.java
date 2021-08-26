package com.example.demo.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.example.demo.dto.Article;
import com.example.demo.dto.Note;

@Mapper
public interface NoteDao {

	public void send(@Param(value="sUid") int sUid, @Param(value="rUid") int rUid, @Param(value="body") String body);

	public int getNotesCnt(@Param(value="uid") int uid, @Param(value="noteType") String noteType);

	public List<Article> getNotes(@Param(value="page") int page, @Param(value="pageCnt") int pageCnt, @Param(value="noteType") String noteType, @Param(value="uid") int uid);

	public Note getNote(@Param(value="nid") int nid);

	public void delete(@Param(value="nid") int nid, @Param(value="noteType") String noteType);
}
