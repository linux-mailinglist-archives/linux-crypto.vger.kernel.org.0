Return-Path: <linux-crypto+bounces-15066-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE6C2B17189
	for <lists+linux-crypto@lfdr.de>; Thu, 31 Jul 2025 14:52:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F54F4E49EA
	for <lists+linux-crypto@lfdr.de>; Thu, 31 Jul 2025 12:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35CC72BE7D9;
	Thu, 31 Jul 2025 12:52:31 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3EA9229B15
	for <linux-crypto@vger.kernel.org>; Thu, 31 Jul 2025 12:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753966351; cv=none; b=OlY8FoL4rwLTrKt4tFrRE/C54f5eHqgB5pD+r+CWQQQqL/u5bM1A17HbAy45g7GH/vCyD4SaYUKvwDJ828MonD3yxUviHWuvmAERCj1cZ0pzmbzv5rIg3aSWLZ5TaMTOnlpXGT/WzYw14T1STlE6mCPwdp2nCi+Ecpa46cE5rss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753966351; c=relaxed/simple;
	bh=yHicCcL9U3t0KFPKavAanflT0YgueRr+UiCNnvr87e8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=qKUVYSmJve03hKgT9kJSZM+4U5GmtNwrAqcsMZdwFpTaFP6kKSRSzbv8MDMQF+3HlljYIOpWGw0u0XUFrKxQ+9cfsezP14Tbdv0Si27p37uLa8g3HvrUXB6tbSaLUwV/69OBaWqDj6JBnrFOJq9JUjIP02kgAbDSt5IUaVpO/Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3e3ecc7278bso21669045ab.1
        for <linux-crypto@vger.kernel.org>; Thu, 31 Jul 2025 05:52:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753966349; x=1754571149;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=399+Wb0FRaCeSxFUAh8KUSIXMYbZIz9r7Bc+x+aJ+F0=;
        b=LWO1A9Grd3GVH9qhe7RGUe8+QcJL9wEuJ2j08buFT6InV79J4Ebaw3gi6XGy77AtgM
         csozS9/Exvbp+qxrY38MfbR75LjZbN4bayGII0cHfwVIHj25WmAyZjbpQ+yDxMBcku2B
         X2i6RqvzsMHRBuztOEPa6v6g2WordJNwXlsZmYmQOWxUbWnEb3BsSXBnrukp/qVpbEuS
         P1kLuZBmAJO5bjQuvEz7RKps0+fangzLhMheo3oXp5Pe3wdHlj6gHQXTdf9IwlEjRMGO
         BVedfpTvDjnhxIDcZnZwezjSw9rQUM0MfRmEi86PI3sXuIvubYqihMMB3Ti5fzbtT46C
         lB4g==
X-Gm-Message-State: AOJu0Yw04SShBCo35BcYuFq/WBkE5LnTSdx2m16+s4Q3Ico5cxGfMcx6
	pcpQbFaG0ZiUd6HHaiqw5qi/naQojv5fErgnfrRcbsq5gn3JPizpsrrChni0a4/4JTlLDgVTTWD
	CK9jMFU3iTGxBTFAlSWcdbFLEW2SWyzOuvV6sejuVzMAQx8AOcZqz+i4e/zg=
X-Google-Smtp-Source: AGHT+IElHCqOHqATHCpjNZ/+BdTbd4ngNPmX+IeQ2w6ywYQCGYxz8WLyPy3MuNQfBqirGD1x0L6eXNNwH/5zL/1uo19FpGrx/VxM
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1749:b0:3e2:a749:252e with SMTP id
 e9e14a558f8ab-3e3f60c392fmr117815645ab.4.1753966348159; Thu, 31 Jul 2025
 05:52:28 -0700 (PDT)
Date: Thu, 31 Jul 2025 05:52:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <688b670c.a00a0220.26d0e1.0040.GAE@google.com>
Subject: [syzbot] Monthly crypto report (Jul 2025)
From: syzbot <syzbot+list563953ef1f0201d6545a@syzkaller.appspotmail.com>
To: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello crypto maintainers/developers,

This is a 31-day syzbot report for the crypto subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/crypto

During the period, 0 new issues were detected and 0 were fixed.
In total, 4 issues are still open and 110 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 52      No    possible deadlock in padata_do_serial
                  https://syzkaller.appspot.com/bug?extid=bd936ccd4339cea66e6b
<2> 11      No    KMSAN: uninit-value in sw842_decompress (2)
                  https://syzkaller.appspot.com/bug?extid=8f77ff6144a73f0cf71b
<3> 4       Yes   KASAN: slab-out-of-bounds Read in xlog_cksum
                  https://syzkaller.appspot.com/bug?extid=9f6d080dece587cfdd4c

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

