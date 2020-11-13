Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9C022B1D8B
	for <lists+linux-crypto@lfdr.de>; Fri, 13 Nov 2020 15:34:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726439AbgKMOeu (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 13 Nov 2020 09:34:50 -0500
Received: from mail.zx2c4.com ([192.95.5.64]:36701 "EHLO mail.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726336AbgKMOeu (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 13 Nov 2020 09:34:50 -0500
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTP id d62a9a21
        for <linux-crypto@vger.kernel.org>;
        Fri, 13 Nov 2020 14:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=D/5agUQ7oYBGjFkEleMmRtkIOn0=; b=PaVPav
        m/mKJtvLw8t2O3TDj3DwKzLLJdzbjjc9ya3Ez3cWbFvQ1gWvTmBonEKrbJlzJ2Y+
        6aB1TS2QTlyn395eF9npOpIdvVdsEO14GwnPVSIAmXzEkRe/UyFRnuwh7PceL/dh
        zjgiIWS/8WfJAZ5vzDzVFhAJJ3wpnhrzrlhZiAGHbViypjlHnkIm0dliPmo31PpM
        e8IqGorzZf0fk8uA+YGWRbyssrpD73Fc7MmuHiOlaV5sZZsjFnpYsDj5j6eR2mYC
        57lgaC+P+H2lMFmpxFOGhegqMqrCiaM1lvLVwi0w3jjn9hHZ8NyyNLzOEfp8KsXr
        qRnpLQGwyEZpgU5g==
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id aab55d45 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
        for <linux-crypto@vger.kernel.org>;
        Fri, 13 Nov 2020 14:31:28 +0000 (UTC)
Received: by mail-yb1-f169.google.com with SMTP id o71so8573878ybc.2
        for <linux-crypto@vger.kernel.org>; Fri, 13 Nov 2020 06:34:48 -0800 (PST)
X-Gm-Message-State: AOAM533zeycPSnHm/EOcGVnPCbXsLHwk5M5QQOogB0AqPyqPUCiOhtAt
        Haxpw90rOBUIb3iPj11mh0V34QnxThWVNGaq47c=
X-Google-Smtp-Source: ABdhPJx5g6zfgJK4ZPuH9fmQIUrihO8/AuzOxsobiArxkbVOl9I/jEHFuglXBJMPisxVDuP5wNqiDClPCzUlgFZVohw=
X-Received: by 2002:a25:6f83:: with SMTP id k125mr3325444ybc.123.1605278087667;
 Fri, 13 Nov 2020 06:34:47 -0800 (PST)
MIME-Version: 1.0
References: <20201102134815.512866-1-Jason@zx2c4.com> <20201113050949.GA8350@gondor.apana.org.au>
In-Reply-To: <20201113050949.GA8350@gondor.apana.org.au>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Fri, 13 Nov 2020 15:34:36 +0100
X-Gmail-Original-Message-ID: <CAHmME9r=myLmSJMvjDff_VG4ya2_Q-22=F+=kOucnYwqzZTxWg@mail.gmail.com>
Message-ID: <CAHmME9r=myLmSJMvjDff_VG4ya2_Q-22=F+=kOucnYwqzZTxWg@mail.gmail.com>
Subject: Re: [PATCH crypto] crypto: Kconfig - CRYPTO_MANAGER_EXTRA_TESTS
 requires the manager
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Thanks. FYI, I intended this for crypto-2.6.git rather than
cryptodev-2.6.git, since it fixes a build failure and is a trivial
fix.
