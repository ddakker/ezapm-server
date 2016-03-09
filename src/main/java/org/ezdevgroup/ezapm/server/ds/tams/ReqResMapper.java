package org.ezdevgroup.ezapm.server.ds.tams;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import java.util.List;
import java.util.Map;

/**
 * Created by ddakker on 2016-03-07.
 */
public interface ReqResMapper {

    @Insert("INSERT INTO ez_apm_req_res (serverNm, threadId, sessionId, uri, ip, stTime) VALUES (#{serverNm}, #{threadId}, #{sessionId}, #{uri}, #{ip}, #{stTime})")
    public int addReq(Map<String, Object> params);

    @Update("UPDATE ez_apm_req_res SET edTime = #{edTime}, `status` = #{status}, res_time = #{resTime} WHERE serverNm = #{serverNm} AND threadId = #{threadId} AND sessionId = #{sessionId} AND uri = #{uri}")
    public int modifyRes(Map<String, Object> params);

}
