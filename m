Return-Path: <linux-crypto+bounces-8087-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F0E849C772D
	for <lists+linux-crypto@lfdr.de>; Wed, 13 Nov 2024 16:30:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1B1AB2D1F0
	for <lists+linux-crypto@lfdr.de>; Wed, 13 Nov 2024 14:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAB9713B2A8;
	Wed, 13 Nov 2024 14:58:19 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B54113AD33
	for <linux-crypto@vger.kernel.org>; Wed, 13 Nov 2024 14:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731509899; cv=none; b=imAswJSrcYWf5MwlclbcY7UjMRaLjHLWelcBnjiwJogj8TmC79DRHhfx2/uOKDIn5oGOXOuiZY0J45mWpmDvQX9McF1kxR7mmCC7vt6ccQJnmeFQsOHn9YZiSnkLugxxktS4+tD/iEpa3uv/f2KLaNCfwBBZ14lUPES4E+GdbHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731509899; c=relaxed/simple;
	bh=exdh0jen8gJ9mpwejxT+xqA37fK0mhqlMiPwb78cBzc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=cbLg41UusFItNhIGv+6AXa9BJka2+jsocbGCDg0v4NlhSppc86K2ojDix75HAc+jQY4jqY181B88R/uQx919JPGjZGXxAKbmMygARDpKlAkr5l5IldwdKjMJZOmoJI7js68XJsUpAe8Y6Qk4doEJta/N0OMu8zsK+pqPkO1o7b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a6a9cb7efdso69207895ab.1
        for <linux-crypto@vger.kernel.org>; Wed, 13 Nov 2024 06:58:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731509897; x=1732114697;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8GJ/SEsOZ1L2zRPT0EKbNi1emDrxhVhdS5kZc6L38K8=;
        b=wJjgO5xkgwUiDDqxos+FP6FCxukHBzFQxxnufSxhVdHEuNzBB3IRWHkHZIXhGeP5U4
         cExdh/EDkA3g3sxNU94XiDwP46WbSyjej7YXnH1QJThAjOMAu+bCKEp7TtsZRxIusF+H
         daeDmC4EmEEX9gMqMB5bEwJKBpx2/A+OpHBqQr02IpLoQeLMvZiauV8WRhN4zrQIeKk/
         tl3/jvgu+AxS4Wz3v8PF9cFLCkwt/uN1Zx6FdLSIiXVpGrb033/5U16/wq3QWJWd+8/o
         JfnMhzzg6ZaOPMUPSc+y7LFiOQv8/0bUWFfByY4pQDxLlEy5cVmKqyj4JxCQKStTbWMw
         MbdQ==
X-Forwarded-Encrypted: i=1; AJvYcCVaedNDHvPRFuUjuwI35hpdfQPtjBBMnI4st8T5wDY0b7fp8+mn+NeGqB3XSUpZBu0+eZTEoWedaIMPvV0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwB3lzdcfLBadKYxAOmd/0X9BT4xXOfTrbVcssia/rgN9U4+5QU
	nUL4cxRFi2r2w0uVqjAlwEWh6X/e5L/sT474ASQ5l+jPvtWlwFi74wF51W9xFuTy69zzJyRSPci
	JS9ntAtW21erXjg9D1qCrqnuYX/ynEBJdOEW5mqQriA8kUwvswSALnTM=
X-Google-Smtp-Source: AGHT+IFdpJh7swVHysfoFHkNwIHE7i3Gm322gFw+xNV0Im9qT4AgjHK3u54DyfAuje5rwqoW2/jpSgUiJFCeBK78tF2+EyGpGd8U
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1949:b0:3a6:bb36:ac1f with SMTP id
 e9e14a558f8ab-3a6f1a45467mr205631175ab.22.1731509897270; Wed, 13 Nov 2024
 06:58:17 -0800 (PST)
Date: Wed, 13 Nov 2024 06:58:17 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6734be89.050a0220.1324f8.0049.GAE@google.com>
Subject: [syzbot] Monthly crypto report (Nov 2024)
From: syzbot <syzbot+listbb9cdfe92636134be785@syzkaller.appspotmail.com>
To: davem@davemloft.net, herbert@gondor.apana.org.au, 
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello crypto maintainers/developers,

This is a 31-day syzbot report for the crypto subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/crypto

During the period, 0 new issues were detected and 0 were fixed.
In total, 4 issues are still open and 107 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 228     Yes   BUG: unable to handle kernel paging request in crypto_skcipher_encrypt
                  https://syzkaller.appspot.com/bug?extid=026f1857b12f5eb3f9e9
<2> 15      Yes   KMSAN: uninit-value in sw842_compress
                  https://syzkaller.appspot.com/bug?extid=17cae3c0a5b0acdc327d
<3> 6       Yes   BUG: unable to handle kernel paging request in crypto_shash_update
                  https://syzkaller.appspot.com/bug?extid=e46f29a4b409be681ad9

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

