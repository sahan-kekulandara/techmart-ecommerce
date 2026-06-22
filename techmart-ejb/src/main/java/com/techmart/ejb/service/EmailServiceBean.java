package com.techmart.ejb.service;

import com.techmart.api.service.EmailService;
import jakarta.ejb.Stateless;
import jakarta.mail.*;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;

import java.util.Properties;

@Stateless
public class EmailServiceBean implements EmailService {

    @Override
    public void sendVerificationEmail(String email, String verificationLink) {

        try {

            final String username =
                    "sahanp.kekulandara@gmail.com";

            final String password =
                    "acwq uezb efwg vvfz";

            Properties props = new Properties();

            props.put(
                    "mail.smtp.auth",
                    "true");

            props.put(
                    "mail.smtp.starttls.enable",
                    "true");

            props.put(
                    "mail.smtp.host",
                    "smtp.gmail.com");

            props.put(
                    "mail.smtp.port",
                    "587");

            Session session =
                    Session.getInstance(
                            props,
                            new Authenticator() {

                                @Override
                                protected PasswordAuthentication
                                getPasswordAuthentication() {

                                    return new PasswordAuthentication(
                                            username,
                                            password);
                                }
                            });

            Message message =
                    new MimeMessage(session);

            message.setFrom(
                    new InternetAddress(username));
            message.setRecipients(
                    Message.RecipientType.TO,
                    InternetAddress.parse(email));

            message.setSubject(
                    "Verify your TechMart account");

            message.setText(
                    "Click the link below:\n\n"
                            + verificationLink);

            Transport.send(message);
        } catch (MessagingException e) {
            throw new RuntimeException(e);
        }

    }
}
