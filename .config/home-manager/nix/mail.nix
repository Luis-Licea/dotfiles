{...}: {
  accounts.email = {
    maildirBasePath = "Documents/Mail";
    accounts.luislicea1011 = rec {
      address = "luislicea1011@hotmail.com";
      userName = address;
      imap.host = "outlook.office365.com";
      smtp.host = "smtp.office365.com";
      mbsync = {
        enable = true;
        create = "maildir";
      };
      msmtp.enable = true;
      notmuch.enable = true;
      neomutt.enable = true;
      primary = true;
      realName = "Luis David Licea Torres";
      # signature = {
      #   text = ''
      #     Luis David Licea Torres
      #     <phone>
      #   '';
      #   showSignature = "append";
      # };
      # gpg = {
      #   key = "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA";
      #   signByDefault = true;
      # };
      passwordCommand = "pass login.live.com/${address}";
    };
  };
}
