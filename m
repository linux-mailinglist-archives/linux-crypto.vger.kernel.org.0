Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CEC2D177052
	for <lists+linux-crypto@lfdr.de>; Tue,  3 Mar 2020 08:48:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727636AbgCCHsX (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 3 Mar 2020 02:48:23 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51483 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727522AbgCCHsX (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 3 Mar 2020 02:48:23 -0500
Received: by mail-wm1-f68.google.com with SMTP id a132so1909253wme.1;
        Mon, 02 Mar 2020 23:48:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=S8P0LJ7u6TOFiOZkcDuJhkn/2H/OUG6d25AO7qTixAo=;
        b=tMa+sriRSXr26gkkZ4JOU3NXaWVStazw6D0JzFbiDcrFlgTwuPRxVCf7o+qeIiZyTm
         JBOi2SNBcUmyhgEJ/KaJJJNSWRxgysSYVcrsSC9jWhHBhms7GOR2TR1Kt2SOl3IVG7Bt
         30Otju7A1JXFcA5EQqEs75Tk4uJPFn2Ir541JbO8i5abn7JysWqJiI29d5btGTaU+Vgq
         s6EYCzVdxTEWSlTw/x6tWkL60zjp1D7iT+awm03HbsIaqGwnqAE+9Hxk/omN6XwmdlG/
         K9nejPTIClizao5I2hVcpTxLE7R3s+H8x3/dxputV6u78wni6kFrPWq9R1H3xzwo+0xC
         My6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=S8P0LJ7u6TOFiOZkcDuJhkn/2H/OUG6d25AO7qTixAo=;
        b=nZFTEnGIeDnT0YuRwTNyYUYmsW+uWEjuJ4lEor6aOVViRYdWBJKGPdLcj7oIacZ5Sa
         f4rFCmW3FD+/LAISBd0uTRSWgHw6WRzCBnnKpe4xjMKISN2DStDHdylc2eMfEpOeJs7k
         fwf15M/Kg/my3KRNSt/32JgJYTfIvHbVwggbwbbvCAC00h8e1/qIHD1XWraA9T8SNr5E
         ZSLpjfdaDMWf0agxQNjl0yutB9USAg/ivyuoIw3LgaIJ55YVbtGRTUR38lg4mcX/fu+/
         bBLjxpQlkONFgOK2PhWAJ2fsnfrtEJx3Dm0SD2C0cobbFdoAEncTZJ2tetC8fao2TJuQ
         dQ8w==
X-Gm-Message-State: ANhLgQ2tk2fQdQTz+lbv34D505yZesZVbsJ1H4DPdo0ljhlkkjNRqS8z
        mbwOUyxbjvUQN+Ovav8LnVY=
X-Google-Smtp-Source: ADFU+vu8Gb4tXqwFBAViua1vl9+zS/LE0+lNqsDQ5GogCnCEm1+FqStbg/GYbA8hHXs7Zpj3rdrq3g==
X-Received: by 2002:a1c:1fd0:: with SMTP id f199mr2833854wmf.168.1583221702071;
        Mon, 02 Mar 2020 23:48:22 -0800 (PST)
Received: from Red ([2a01:cb1d:3d5:a100:2e56:dcff:fed2:c6d6])
        by smtp.googlemail.com with ESMTPSA id z64sm2537257wmg.35.2020.03.02.23.48.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2020 23:48:21 -0800 (PST)
Date:   Tue, 3 Mar 2020 08:48:19 +0100
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     Daniel Jordan <daniel.m.jordan@oracle.com>
Cc:     Will Deacon <will@kernel.org>, tj@kernel.org,
        jiangshanlai@gmail.com, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-crypto@vger.kernel.org
Subject: Re: WARNING: at kernel/workqueue.c:1473 __queue_work+0x3b8/0x3d0
Message-ID: <20200303074819.GB9935@Red>
References: <20200217204803.GA13479@Red>
 <20200218163504.y5ofvaejleuf5tbh@ca-dmjordan1.us.oracle.com>
 <20200220090350.GA19858@Red>
 <20200221174223.r3y6tugavp3k5jdl@ca-dmjordan1.us.oracle.com>
 <20200228123311.GE3275@willie-the-truck>
 <20200228153331.uimy62rat2tdxxod@ca-dmjordan1.us.oracle.com>
 <20200301175351.GA11684@Red>
 <20200302172510.fspofleipqjcdxak@ca-dmjordan1.us.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200302172510.fspofleipqjcdxak@ca-dmjordan1.us.oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Mon, Mar 02, 2020 at 12:25:10PM -0500, Daniel Jordan wrote:
> On Sun, Mar 01, 2020 at 06:53:51PM +0100, Corentin Labbe wrote:
> > I tried to bisect this problem, but the result is:
> ...
> > # first bad commit: [81ff5d2cba4f86cd850b9ee4a530cd221ee45aa3] Merge branch 'linus' of git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6
> > 
> > The only interesting thing I see in this MR is: "Add fuzz testing to testmgr"
> > 
> > But this wont help.
> 
> Hm, that merge commit has only a couple lines of powerpc build change, so maybe
> there's something nondeterministic going on.
> 
> Does this fix it?  I can't verify but figure it's worth trying the simplest
> explanation first, which is that the work isn't initialized by the time it's
> queued.
> 
> thanks,
> daniel
> 
> ---8<---
> 
> Subject: [PATCH] module: statically initialize init section freeing data
> 
> Signed-off-by: Daniel Jordan <daniel.m.jordan@oracle.com>
> ---
>  kernel/module.c | 13 +++----------
>  1 file changed, 3 insertions(+), 10 deletions(-)
> 
> diff --git a/kernel/module.c b/kernel/module.c
> index 33569a01d6e1..db0cda206167 100644
> --- a/kernel/module.c
> +++ b/kernel/module.c
> @@ -88,8 +88,9 @@ EXPORT_SYMBOL_GPL(module_mutex);
>  static LIST_HEAD(modules);
>  
>  /* Work queue for freeing init sections in success case */
> -static struct work_struct init_free_wq;
> -static struct llist_head init_free_list;
> +static void do_free_init(struct work_struct *w);
> +static DECLARE_WORK(init_free_wq, do_free_init);
> +static LLIST_HEAD(init_free_list);
>  
>  #ifdef CONFIG_MODULES_TREE_LOOKUP
>  
> @@ -3501,14 +3502,6 @@ static void do_free_init(struct work_struct *w)
>  	}
>  }
>  
> -static int __init modules_wq_init(void)
> -{
> -	INIT_WORK(&init_free_wq, do_free_init);
> -	init_llist_head(&init_free_list);
> -	return 0;
> -}
> -module_init(modules_wq_init);
> -
>  /*
>   * This is where the real work happens.
>   *

Hello

The patch fix the issue. Thanks!

So you could add:
Reported-by: Corentin Labbe <clabbe.montjoie@gmail.com>
Tested-by: Corentin Labbe <clabbe.montjoie@gmail.com>
Tested-on: sun50i-h6-pine-h64
Tested-on: imx8mn-ddr4-evk
Tested-on: sun50i-a64-bananapi-m64

Thanks again
Regards
