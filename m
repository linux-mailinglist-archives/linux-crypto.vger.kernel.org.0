Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55AA52C32C2
	for <lists+linux-crypto@lfdr.de>; Tue, 24 Nov 2020 22:27:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731930AbgKXVZt (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 24 Nov 2020 16:25:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731832AbgKXVZq (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 24 Nov 2020 16:25:46 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88575C094242
        for <linux-crypto@vger.kernel.org>; Tue, 24 Nov 2020 13:25:44 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id s63so341372pgc.8
        for <linux-crypto@vger.kernel.org>; Tue, 24 Nov 2020 13:25:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Hc7xHQdcWqcI1RL6yWHK3qM7+D3PcB+9wJ1f+Y4kOZ8=;
        b=oKmDT/E0BiqfYtxGd9S8VgvaixpTRLnYMRrsUV9kaRuJo3R/5oNlOHAboaJA72rvz5
         cPy+dYNpKpp/tW1abpWiBH/rmtZxXE/MLGj7m5uMt/n+RU1YTE1Rw6QIxNLzAajuHLbW
         OV/WWZm28UqOigi5ggHh0BMVZishCwQGNb1Ns=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Hc7xHQdcWqcI1RL6yWHK3qM7+D3PcB+9wJ1f+Y4kOZ8=;
        b=pIgycnhz2HCPIovUNHc7O2F/32gPxlArguIekOtsg792/XsPG5cTIpE7HIkebIlH+P
         5E5tJafvvVR0eGAw4Hb4os806KTO81Im6q0oWigcIkK8Pods9uaJWa0nxujarhGRZuJ5
         hm28ST6PAzhHhtDCLVpe1iDNzwLmjlckkXvRFhMCSo1zP6E25A4WcMqfMt8aOJetvOEX
         nnlxTr4a5G3VtX10XQWIT61ELRkqFTJq9MZUtM+8JLKhwSspkCzQscssMc4ySbiUbVpb
         B0YwMv0sqpM+r1o12xmq0Cz6nUrA/ucSvGRPWldx6/JPlOriZZLmOhWzXwF717+S1sdD
         ANxQ==
X-Gm-Message-State: AOAM531WXNAtaZgsvRrHAg1VxhFDLMCW6ak8QVXCvN6Z3MDPyo+FGc6g
        xAgKkUPXWMVK8FeHoQ+vZAcVVQ==
X-Google-Smtp-Source: ABdhPJwtm7ki1o3tlMghBzBMLVUzEcZQN+PDIoPgB8WI7uCPSXlOMvf7LiH3SXaewZBRcFltugq6wg==
X-Received: by 2002:a17:90b:3505:: with SMTP id ls5mr176054pjb.55.1606253143764;
        Tue, 24 Nov 2020 13:25:43 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z68sm129381pgb.37.2020.11.24.13.25.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 13:25:41 -0800 (PST)
Date:   Tue, 24 Nov 2020 13:25:40 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Jakub Kicinski <kuba@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, alsa-devel@alsa-project.org,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        bridge@lists.linux-foundation.org, ceph-devel@vger.kernel.org,
        cluster-devel@redhat.com, coreteam@netfilter.org,
        devel@driverdev.osuosl.org, dm-devel@redhat.com,
        drbd-dev@lists.linbit.com,
        dri-devel <dri-devel@lists.freedesktop.org>,
        GR-everest-linux-l2@marvell.com, GR-Linux-NIC-Dev@marvell.com,
        intel-gfx@lists.freedesktop.org, intel-wired-lan@lists.osuosl.org,
        keyrings@vger.kernel.org, linux1394-devel@lists.sourceforge.net,
        linux-acpi@vger.kernel.org, linux-afs@lists.infradead.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-atm-general@lists.sourceforge.net,
        linux-block@vger.kernel.org, linux-can@vger.kernel.org,
        linux-cifs@vger.kernel.org,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        linux-decnet-user@lists.sourceforge.net,
        linux-ext4@vger.kernel.org, linux-fbdev@vger.kernel.org,
        linux-geode@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-hams@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-i3c@lists.infradead.org, linux-ide@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-input@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-media@vger.kernel.org,
        linux-mmc@vger.kernel.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-mtd@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-rdma@vger.kernel.org,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        linux-scsi@vger.kernel.org, linux-sctp@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-usb@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        netfilter-devel@vger.kernel.org, nouveau@lists.freedesktop.org,
        op-tee@lists.trustedfirmware.org, oss-drivers@netronome.com,
        patches@opensource.cirrus.com, rds-devel@oss.oracle.com,
        reiserfs-devel@vger.kernel.org, samba-technical@lists.samba.org,
        selinux@vger.kernel.org, target-devel@vger.kernel.org,
        tipc-discussion@lists.sourceforge.net,
        usb-storage@lists.one-eyed-alien.net,
        virtualization@lists.linux-foundation.org,
        wcn36xx@lists.infradead.org,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        xen-devel@lists.xenproject.org, linux-hardening@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>,
        Miguel Ojeda <ojeda@kernel.org>, Joe Perches <joe@perches.com>
Subject: Re: [PATCH 000/141] Fix fall-through warnings for Clang
Message-ID: <202011241324.B3439A2@keescook>
References: <cover.1605896059.git.gustavoars@kernel.org>
 <20201120105344.4345c14e@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <202011201129.B13FDB3C@keescook>
 <20201120115142.292999b2@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <202011220816.8B6591A@keescook>
 <CAKwvOdntVfXj2WRR5n6Kw7BfG7FdKpTeHeh5nPu5AzwVMhOHTg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdntVfXj2WRR5n6Kw7BfG7FdKpTeHeh5nPu5AzwVMhOHTg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Mon, Nov 23, 2020 at 05:32:51PM -0800, Nick Desaulniers wrote:
> On Sun, Nov 22, 2020 at 8:17 AM Kees Cook <keescook@chromium.org> wrote:
> >
> > On Fri, Nov 20, 2020 at 11:51:42AM -0800, Jakub Kicinski wrote:
> > > If none of the 140 patches here fix a real bug, and there is no change
> > > to machine code then it sounds to me like a W=2 kind of a warning.
> >
> > FWIW, this series has found at least one bug so far:
> > https://lore.kernel.org/lkml/CAFCwf11izHF=g1mGry1fE5kvFFFrxzhPSM6qKAO8gxSp=Kr_CQ@mail.gmail.com/
> 
> So looks like the bulk of these are:
> switch (x) {
>   case 0:
>     ++x;
>   default:
>     break;
> }
> 
> I have a patch that fixes those up for clang:
> https://reviews.llvm.org/D91895

I still think this isn't right -- it's a case statement that runs off
the end without an explicit flow control determination. I think Clang is
right to warn for these, and GCC should also warn.

-- 
Kees Cook
