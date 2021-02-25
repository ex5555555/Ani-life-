package tw.iii.config;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.mysql.cj.x.protobuf.MysqlxCrud.Collection;

import tw.iii.model.Member;
import tw.iii.model.MemberService;

@Service
public class DemoUserDetailsService implements UserDetailsService {

	@Autowired
	private MemberService mbs;

	@Override
	public UserDetails loadUserByUsername(String account) throws UsernameNotFoundException {

		System.out.println(account);

		Member mb = mbs.selecter(account);
		if (mb == null) {
			throw new UsernameNotFoundException(account + "not found");
		}

		System.out.println(mb.getAccount());
		System.out.println(mb.getPassword());

		List<GrantedAuthority> authorities = new ArrayList<GrantedAuthority>();
		authorities.add(new SimpleGrantedAuthority("ROLE_USER"));

		return new User(mb.getAccount(), mb.getPassword(), authorities);
	}

}
