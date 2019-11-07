Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7448F3927
	for <lists+linux-crypto@lfdr.de>; Thu,  7 Nov 2019 21:05:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726118AbfKGUFl (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 7 Nov 2019 15:05:41 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44689 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725785AbfKGUFl (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 7 Nov 2019 15:05:41 -0500
Received: by mail-pl1-f193.google.com with SMTP id az9so1465518plb.11
        for <linux-crypto@vger.kernel.org>; Thu, 07 Nov 2019 12:05:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=Sn3H3USYo7BZToUu8oTrq01WdHO2mboQb5HVlpeRiKU=;
        b=zrnACrcqsS2nzZa62EllyvKRCMH6Xpw6xK4qtFHcCoI6JgHhSQTKLdaelc5GJvsini
         Oa3vn1I56tihebF1k6Eri2QUUD77LabYMtvF/m/EVozcVpT6Kf2JVDh7iqs5w3ExN4Z3
         5zTpG7h+lKNQAoih+3IwDuoTlgPb8eeu9E3XKmtDCwciFe2BatUH2akmOR80S8+WxK5O
         7nHwOOm0eq2IK3azfr3Hkr1I7mlLWqxEPPDzW7TA7PreJZDFe5666TD/NeujpVm4SmYO
         LD5pytA58EY7pZ3yx3JBUFUAAPVX5H8Txi0hG6SHfUSBTOCJCVVbJCR6z9vvAnr6yYub
         lIiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=Sn3H3USYo7BZToUu8oTrq01WdHO2mboQb5HVlpeRiKU=;
        b=cY0bBkDF6oHvg+bL8qLCNM0cqLVCubfUcRn2cZvnmPojsfwgyzYCUTijspXID829Mj
         McBjzl9rb/wBPTeRXoYkdslngq1AU+7l+IszOAhgrMabdUizom6v/u+EUHouB5zcJa8w
         aJDLebVmiAFQbrd24w380h55Dlbk12g5KPqWjMGFFmt+xY0DBG0UB8Mb3AEdwVYCU90/
         OYL9n1qJoqUvOILb1e9iM1qgzEPgXxhZdGeghUnDpsRZXtxkcA0n3VsUU+oVZmXR9cfy
         03S8PFTJfUgrC+gwfFyXyP8gAvEgs+Bn/65WHoaWaG7uUFrpY59d/g1Jpp0v7ofcajbA
         wFNQ==
X-Gm-Message-State: APjAAAV9OMu8boMzRcC6MSdyF0HVLGnPi9hEq/t9rspNvSnHHvn/jDFS
        hVU7RT97Np86dlP1gGMqaMB8UA==
X-Google-Smtp-Source: APXvYqxWJNQvlbKIguc4Z/QM2uQTi9gQTGUknCkgIqxTfIQYWu4kMMdmOd+rr2Z9plzKxIsinf1bng==
X-Received: by 2002:a17:902:161:: with SMTP id 88mr5368963plb.253.1573157139042;
        Thu, 07 Nov 2019 12:05:39 -0800 (PST)
Received: from cakuba.netronome.com ([65.196.126.174])
        by smtp.gmail.com with ESMTPSA id s18sm4398210pfm.27.2019.11.07.12.05.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 12:05:38 -0800 (PST)
Date:   Thu, 7 Nov 2019 15:05:18 -0500
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     syzbot <syzbot+e736399a2c4054612307@syzkaller.appspotmail.com>
Cc:     Jason@zx2c4.com, ard.biesheuvel@linaro.org, aviadye@mellanox.com,
        borisp@mellanox.com, daniel@iogearbox.net, davejwatson@fb.com,
        davem@davemloft.net, dhowells@redhat.com,
        dirk.vandermerwe@netronome.com, ebiggers3@gmail.com,
        herbert@gondor.apana.org.au, john.fastabend@gmail.com,
        k.marinushkin@gmail.com, keescook@chromium.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, security@kernel.org,
        steffen.klassert@secunet.com, syzkaller-bugs@googlegroups.com
Subject: Re: KASAN: use-after-free Read in crypto_gcm_init_common
Message-ID: <20191107150518.36b4a872@cakuba.netronome.com>
In-Reply-To: <000000000000dd9f160596c1d465@google.com>
References: <00000000000060e0ae057a092be8@google.com>
        <000000000000dd9f160596c1d465@google.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Thu, 07 Nov 2019 05:42:07 -0800, syzbot wrote:
> syzbot suspects this bug was fixed by commit:
> 
> commit 9354544cbccf68da1b047f8fb7b47630e3c8a59d
> Author: Dirk van der Merwe <dirk.vandermerwe@netronome.com>
> Date:   Mon Jun 24 04:26:58 2019 +0000
> 
>      net/tls: fix page double free on TX cleanup
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=168ad3c2600000
> start commit:   4710e789 Merge tag 'nfs-for-4.20-2' of git://git.linux-nfs..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=9384ecb1c973baed
> dashboard link: https://syzkaller.appspot.com/bug?extid=e736399a2c4054612307
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17902f5b400000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=111377e5400000
> 
> If the result looks correct, please mark the bug fixed by replying with:
> 
> #syz fix: net/tls: fix page double free on TX cleanup
> 
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

The bug report looks fairly strange and could indicate a double free,
but I don't see an entirely clear connection. We are double freeing a
record and its pages while the splat is from a slab-32.. Given the
bisection I think it's probably okay:

#syz fix: net/tls: fix page double free on TX cleanup
