package tw.iii.Backstage.Controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import tw.iii.model.Member;
import tw.iii.model.MemberDAO;
import tw.iii.model.MemberService;

@Controller
public class BackSideMemberController {
	@Autowired
	private MemberService mbs;
	
	@Autowired
	private MemberDAO mbsdoa;
	
	
	private Member mb;
	
	@RequestMapping(path = "/selectAllMember",method = RequestMethod.GET)
	public String selectAllMember(Model m,@RequestParam(name = "eeaccount") String eeaccount) {
		m.addAttribute("selection", "all");
		m.addAttribute("memberList", mbsdoa.selectAll());
		m.addAttribute("eeaccount",eeaccount);
		return "/WEB-INF/Backstage/backSideMember.jsp";
	}

	@RequestMapping(path = "/updateauthority",method = RequestMethod.POST)
	public String updateAuthority(@RequestParam(name = "account") String account,@RequestParam(name = "pdauthority") String pdauthority
			,@RequestParam(name = "frauthority") String frauthority,Model m,@RequestParam(name = "eeaccount") String eeaccount) {
		mb = mbsdoa.selecter(account);
		mbsdoa.updateAuthority(account, pdauthority, frauthority);
		m.addAttribute("selection", "all");
//		m.addAttribute("memberList", mbs.select(account));
		m.addAttribute("memberList", mbsdoa.selectAll());
		m.addAttribute("eeaccount",eeaccount);
		return "/WEB-INF/Backstage/backSideMember.jsp";
	}
}