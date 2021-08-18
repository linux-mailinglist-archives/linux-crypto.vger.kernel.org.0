Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59C023F0DB8
	for <lists+linux-crypto@lfdr.de>; Wed, 18 Aug 2021 23:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234402AbhHRVvp (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 18 Aug 2021 17:51:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234261AbhHRVvo (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 18 Aug 2021 17:51:44 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01F5DC0617A8
        for <linux-crypto@vger.kernel.org>; Wed, 18 Aug 2021 14:51:08 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id u15so2660364plg.13
        for <linux-crypto@vger.kernel.org>; Wed, 18 Aug 2021 14:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7vHz7lx5HT3o9dUfiJevKg/RCUhyC9oP+KAo7KKSobE=;
        b=a0gIT1PbsUrzpiMxHFJQf3jDySrUQ8Ww2Lki+TjewXrAJP5UxO7103vV2RR/V3ANRN
         1nLuL/Iv5GOFWegVwgew6XfBqxD/P2xI/kCXdGtAH6LbMiGNGZJvf9jRwo8l9cGtJXp/
         NJhI01VKo66AWmiNMy8NublWXQfmYUotQ1JOg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7vHz7lx5HT3o9dUfiJevKg/RCUhyC9oP+KAo7KKSobE=;
        b=ftCb83IlpAlH7WQf59u8DFbilI0FKhQjq0czcpaw4X1rrf6PFLLKQEGK/eJMk+5hl2
         OOb7LjqdbgWwXM8ej6vPDYLAbfsPglqJm+xS+OxEgTyAN5iKOvVtE1vMDsoz2xTF4fSf
         bFgL5k0WIFLbEu7rt39XC7qUD+0dzue35USPMBpITAN9Skq5g0j1GRnCpeEF6CxHKqSS
         flMhsmYnoL2bHhtWDfVa8ltYz18g/omcgJPdH2CyBEkHOWUlbFPR9y5F8NdiDKDwAjrO
         wClslo+bDFCPux94yzxBcj4TUpS454nz/nvmg9J2jafQY3becmd/5vIzxAq4PJ2kv44s
         wazw==
X-Gm-Message-State: AOAM533amVMKGMr1DukNrWOvW7j2NA05sOtavMb8Qvsq7BcNzDnNF0/W
        6dITYXZWEvj1w0eFXj0WprItQw==
X-Google-Smtp-Source: ABdhPJyzlA1BSNScs1NpCi0WnbTUY9sHZCG50/IaKrR4dcNnW411OdaQOYqLBK5zGkg4QWgJ9r2Cng==
X-Received: by 2002:a17:902:b601:b029:12b:d9a:894f with SMTP id b1-20020a170902b601b029012b0d9a894fmr9050350pls.63.1629323468448;
        Wed, 18 Aug 2021 14:51:08 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b190sm808833pgc.91.2021.08.18.14.51.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 14:51:07 -0700 (PDT)
Date:   Wed, 18 Aug 2021 14:51:06 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Ayush Sawal <ayush.sawal@chelsio.com>,
        Vinay Kumar Yadav <vinay.yadav@chelsio.com>,
        Rohit Maheshwari <rohitm@chelsio.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Kalle Valo <kvalo@codeaurora.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Stanislaw Gruszka <stf_xl@wp.pl>,
        Luca Coelho <luciano.coelho@intel.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Johannes Berg <johannes.berg@intel.com>,
        Mordechay Goodstein <mordechay.goodstein@intel.com>,
        Lee Jones <lee.jones@linaro.org>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Arunachalam Santhanam <arunachalam.santhanam@in.bosch.com>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
        linux-crypto@vger.kernel.org, ath10k@lists.infradead.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-can@vger.kernel.org,
        bpf@vger.kernel.org, clang-built-linux@googlegroups.com,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH 2/5] treewide: Replace open-coded flex arrays in unions
Message-ID: <202108181448.9C13CE9@keescook>
References: <20210818081118.1667663-1-keescook@chromium.org>
 <20210818081118.1667663-3-keescook@chromium.org>
 <20210818095635.tm42ctkm6aydjr6g@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210818095635.tm42ctkm6aydjr6g@pengutronix.de>
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Wed, Aug 18, 2021 at 11:56:35AM +0200, Marc Kleine-Budde wrote:
> On 18.08.2021 01:11:15, Kees Cook wrote:
> > diff --git a/drivers/net/can/usb/etas_es58x/es581_4.h b/drivers/net/can/usb/etas_es58x/es581_4.h
> > index 4bc60a6df697..8657145dc2a9 100644
> > --- a/drivers/net/can/usb/etas_es58x/es581_4.h
> > +++ b/drivers/net/can/usb/etas_es58x/es581_4.h
> > @@ -192,7 +192,7 @@ struct es581_4_urb_cmd {
> >  		struct es581_4_rx_cmd_ret rx_cmd_ret;
> >  		__le64 timestamp;
> >  		u8 rx_cmd_ret_u8;
> > -		u8 raw_msg[0];
> > +		flex_array(u8 raw_msg);
> >  	} __packed;
> >  
> >  	__le16 reserved_for_crc16_do_not_use;
> > diff --git a/drivers/net/can/usb/etas_es58x/es58x_fd.h b/drivers/net/can/usb/etas_es58x/es58x_fd.h
> > index ee18a87e40c0..3053e0958132 100644
> > --- a/drivers/net/can/usb/etas_es58x/es58x_fd.h
> > +++ b/drivers/net/can/usb/etas_es58x/es58x_fd.h
> > @@ -228,7 +228,7 @@ struct es58x_fd_urb_cmd {
> >  		struct es58x_fd_tx_ack_msg tx_ack_msg;
> >  		__le64 timestamp;
> >  		__le32 rx_cmd_ret_le32;
> > -		u8 raw_msg[0];
> > +		flex_array(u8 raw_msg[]);
> >  	} __packed;
> 
> This doesn't look consistent, what's preferred?
> 
> u8 raw_msg[0];  -> flex_array(u8 raw_msg);
>  - or-
>                 -> flex_array(u8 raw_msg[]);

Eek, thanks for catching that. And this helps me realize that having
"flex_array" and "[]" is redundant, and the above typo would have been
caught. I will fix this for v2.

Thanks!

-Kees

-- 
Kees Cook
