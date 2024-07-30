{ lib, pkgs, ... }: {
  makeEmailAccount = { passCmd, address, imapHost, smtpHost ? "", smtpPort ? 465, userName ? address, primary ? false, aercExtraAccounts ? { }, aercExtraBinds ? { } }:
    let
      realName = "Maxim Baz";
      pgp-key-id = "56C3E775E72B0C8B1C0C1BD0B5DB77409B11B601";
    in
    {
      realName = realName;
      address = address;
      userName = userName;
      passwordCommand = passCmd;
      imap.host = imapHost;
      smtp =
        if smtpHost != "" then {
          host = smtpHost;
          port = smtpPort;
          tls.enable = true;
          tls.useStartTls = false;
        } else null;
      msmtp.enable = smtpHost != "";
      imapnotify = {
        enable = true;
        onNotify = lib.getExe' pkgs.maximbaz-scripts "checkmail";
        boxes = [ "INBOX" ];
      };
      aerc = {
        enable = true;
        extraBinds = aercExtraBinds;
        extraAccounts = {
          pgp-self-encrypt = true;
          pgp-key-id = pgp-key-id;
          signature-cmd = "echo '${realName}'";
          folders-sort = "INBOX";
        } // aercExtraAccounts;
      };
      notmuch.enable = true;
      mbsync = {
        enable = true;
        create = "both";
        expunge = "both";
        remove = "both";
        extraConfig.channel = {
          CopyArrivalDate = "yes";
        };
      };
      folders.inbox = "INBOX";
      signature = {
        text = realName;
        showSignature = "append";
      };
      primary = primary;
    };
}
