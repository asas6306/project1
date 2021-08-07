package com.example.demo.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.example.demo.dto.Like;

@Mapper
public interface ArticleLikeDao {

	public List<Like> getLikes(@Param(value="aid") int aid);

	public void undoLike(@Param(value="aid") int aid, @Param(value="uid") int uid);

	public void doLike(@Param(value="aid") int aid, @Param(value="uid") int uid);

}
