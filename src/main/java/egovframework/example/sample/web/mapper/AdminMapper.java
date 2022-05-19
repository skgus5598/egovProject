package egovframework.example.sample.web.mapper;

import java.util.ArrayList;

import egovframework.example.sample.web.admin.dto.AdminDTO;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper
public interface AdminMapper {
	
	public int registerAdmin(AdminDTO dto);
	public ArrayList<AdminDTO> memberList();
	public AdminDTO loginCheck( String userEmail);
	public AdminDTO userNickCheck(String userNick);
	public AdminDTO userEmailCheck(String userEmail);

}
