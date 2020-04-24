Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A0AE1B6F9D
	for <lists+linux-crypto@lfdr.de>; Fri, 24 Apr 2020 10:14:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbgDXINm (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 24 Apr 2020 04:13:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbgDXINl (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 24 Apr 2020 04:13:41 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8741C09B045;
        Fri, 24 Apr 2020 01:13:41 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id m18so10958819otq.9;
        Fri, 24 Apr 2020 01:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9dfPGeraK4o9r9iyl1y9Yo9qcc+FG0ESeUD3dyGuhgw=;
        b=lKqcmeOkeMm+YlfFoMTIdJDvtKNH+Net4lPcCtsnDIMy8AYfmPOyLS7SjO9jqlA6jn
         6+xhYwft+NCvscdw3ralt+caYFm0+slGDekfbXJaHPIWBQhraB+tdFeBjONWh56dzgD+
         TDITSMnq8iuveCIEjf0Rs3SQ/So3vKcQ88xKBjdhSYlrgetgm5VDAjQdN/D+esGtwVGk
         lDa7aJEeJ/A7zURoHz9+iq3BUIDArPdRmuzvaOd/NhY9Dt9jjkgX7JqDjW+ieqfiJkyf
         oH7LQMfP7+x+opJL0UWTex3zfvr6S38Ritft8+wtGa5T5Fcua/Dm3jsFQ0dG9Pgfg+kM
         NZxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9dfPGeraK4o9r9iyl1y9Yo9qcc+FG0ESeUD3dyGuhgw=;
        b=Y4cq5LU8aKbidTDnCKUxRdSw7jI7eixjOIaiXyZNI/W/Zfbt6y3cPz9b8xSdfKxrfx
         /oY9jhVl02U+NFxt+pjFXHy58eTczpKAQBJh+omsR25QtCn7GUclv4/8vRCXeguXey2r
         ORUnYitsqZNKUKQsWfl+PF9C+rYLkrOyePLdQnrs87v/KTOM2rn+Eu+SmhZw6/9aRQ/+
         j8JgjlOcAhe+eywt8ad43xlQEUAEOuFK2y35FAsOFAnI9cSVdNNBE5GT8PNaF5r/jEZB
         1Uq8/Jyfk7UsgjcP5XwHf5gGoxd0BbfDS72o7lk2PZraWDiTcfy1F6XU7D3cOixVjYoF
         U1Bw==
X-Gm-Message-State: AGi0PuYGH4+8ls8P5fy9eDLIhfahKnViMm6sNbSg/o9NhRAfXaTrrtqO
        eoTnPqltNpLB0dJoHEEBAyw=
X-Google-Smtp-Source: APiQypKJ2YOD8oDhU3sz3jK6pjD1VxIjJeE5OARyrPPZk06XM//yOeioy1T+fqu3r56/K4rAh4OOIQ==
X-Received: by 2002:aca:b487:: with SMTP id d129mr6408822oif.115.1587716020784;
        Fri, 24 Apr 2020 01:13:40 -0700 (PDT)
Received: from ubuntu-s3-xlarge-x86 ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id m189sm271658oig.12.2020.04.24.01.13.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 24 Apr 2020 01:13:40 -0700 (PDT)
Date:   Fri, 24 Apr 2020 01:13:38 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linux-crypto@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH] lib/mpi: Fix building for powerpc with clang
Message-ID: <20200424081338.GA32106@ubuntu-s3-xlarge-x86>
References: <20200413195041.24064-1-natechancellor@gmail.com>
 <20200414135731.GA8766@gondor.apana.org.au>
 <20200423163602.GA18872@ubuntu-s3-xlarge-x86>
 <87eesdh8hy.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87eesdh8hy.fsf@mpe.ellerman.id.au>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Fri, Apr 24, 2020 at 01:23:37PM +1000, Michael Ellerman wrote:
> Nathan Chancellor <natechancellor@gmail.com> writes:
> > On Tue, Apr 14, 2020 at 11:57:31PM +1000, Herbert Xu wrote:
> >> On Mon, Apr 13, 2020 at 12:50:42PM -0700, Nathan Chancellor wrote:
> >> > 0day reports over and over on an powerpc randconfig with clang:
> >> > 
> >> > lib/mpi/generic_mpih-mul1.c:37:13: error: invalid use of a cast in a
> >> > inline asm context requiring an l-value: remove the cast or build with
> >> > -fheinous-gnu-extensions
> >> > 
> >> > Remove the superfluous casts, which have been done previously for x86
> >> > and arm32 in commit dea632cadd12 ("lib/mpi: fix build with clang") and
> >> > commit 7b7c1df2883d ("lib/mpi/longlong.h: fix building with 32-bit
> >> > x86").
> >> > 
> >> > Reported-by: kbuild test robot <lkp@intel.com>
> >> > Link: https://github.com/ClangBuiltLinux/linux/issues/991
> >> > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> >> 
> >> Acked-by: Herbert Xu <herbert@gondor.apana.org.au>
> >> -- 
> >> Email: Herbert Xu <herbert@gondor.apana.org.au>
> >> Home Page: http://gondor.apana.org.au/~herbert/
> >> PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
> >
> > Might be better for you to take this instead. 0day just tripped over
> > this again.
> 
> Sorry I missed the ack. Will pick it up today.
> 
> cheers

Thank you!

Cheers,
Nathan
