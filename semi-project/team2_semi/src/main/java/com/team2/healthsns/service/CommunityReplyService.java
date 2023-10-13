package com.team2.healthsns.service;

import com.team2.healthsns.vo.CommunityReplyVO;

import java.util.List;

public interface CommunityReplyService {
    public int replyInsert(CommunityReplyVO vo);
    public List<CommunityReplyVO> replySelect(int no);
    public int replyUpdate(CommunityReplyVO vo);
    public int replyDelete(int replyno);
}
