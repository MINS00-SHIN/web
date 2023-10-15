package com.team2.healthsns.mapper;

import com.team2.healthsns.vo.CommunityVO;
import com.team2.healthsns.vo.PagingVO;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface CommunityAuthMapper {
    public int communityInsertAuth(CommunityVO vo);
    public List<CommunityVO> communityPageListAuth(PagingVO pVO);
    public int totalRecordAuth(PagingVO pVO);
    public CommunityVO communitySelectAuth(int post_id);
    //조회수 증가
    public void hitCountAuth(int post_id);
    //게시판 수정
    public int communityUpdateAuth(CommunityVO vo);
    //게시글 삭제
    public int communityDeleteAuth(int post_id);

    public void increaseLike(int post_id);
}
