package mail;
//import java.io.*; 
import java.io.FileOutputStream;
import java.util.Properties;
import javax.mail.*;
import javax.mail.internet.*;

/*
 * 邮件发送程序
 * 使用JavaMail发送一封简单的邮件：
 * 1、创建包含邮件服务器的网络连接信息的Session对象。 
 * 2、创建代表邮件内容的Message对象。 
 * 3、创建Transport对象、连接服务器、发送Message、关闭连接。 
 * 下面以从CSACHUST@126.com   密码：HUSTACCS  给 symdfbb@sina.com 发一封带有图片的邮件为例，代码如下：
 */

public class SendMail {
	private String user = null;
	private String email = null;
	private String bugid = null;
	// send e-mail
	public SendMail(String assign_to, String email, String id) {
//		String assign_to=(String)request.getParameter("assign_to");
		setUsername(assign_to);
		setEmailname(email);
		setBugid(id);
	    // 设置属性
		Properties props = new Properties();
		props.setProperty("mail.host", "smtp.126.com");
		props.setProperty("mail.transport.protocol", "smtp");
		props.setProperty("mail.smtp.auth", "ture");
	
		Session session = Session.getInstance(props);
		Message message = CreatMessage(session);
	
		try {
			Transport trs = session.getTransport();
			trs.connect("CSACHUST", "HUSTACCS");
			trs.sendMessage(message, message.getAllRecipients());
			trs.close();
			System.out.println("Email send end !");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	//创建邮件
	public Message CreatMessage(Session session){
		
	   MimeMessage message=new MimeMessage(session);
	   try {
			//设置属性
			message.setFrom(new InternetAddress("CSACHUST@126.com"));
			message.setRecipient(Message.RecipientType.TO, new InternetAddress(email));
			// 创建邮件体
			// 邮件的主题
			message.setSubject("From BugTrack: NEW BUG TASKS !");
			// 正文
			MimeBodyPart part = new MimeBodyPart();
			part.setContent("Hi,"+user+".<br/><br/>The administrator has assigned a new bug task to you, and please login in the BugTrack System to fix it.<br/><br/>Thanks !", "text/html;charset=iso-8859-1");
			// 描述关系
			MimeMultipart mm = new MimeMultipart();
			mm.addBodyPart(part);
			// 设置
			message.setContent(mm);
			message.saveChanges();
			message.writeTo(new FileOutputStream("C:/bug"+bugid+".eml"));

	   } catch (Exception e) {
	       e.printStackTrace();
	   }
	   return message;
	}
	public void setUsername(String name) {
		user = name;
	}
	public void setEmailname(String name) {
		email = name;
	}
	public void setBugid(String id) {
		bugid = id;
	}
}
