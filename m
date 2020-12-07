Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 254CC2D0D63
	for <lists+linux-crypto@lfdr.de>; Mon,  7 Dec 2020 10:52:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725901AbgLGJvn (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 7 Dec 2020 04:51:43 -0500
Received: from mail-wr1-f43.google.com ([209.85.221.43]:44162 "EHLO
        mail-wr1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbgLGJvm (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 7 Dec 2020 04:51:42 -0500
Received: by mail-wr1-f43.google.com with SMTP id x6so8170303wro.11
        for <linux-crypto@vger.kernel.org>; Mon, 07 Dec 2020 01:51:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Q7pCGsHRFZdBz0qKFRVD5j7QxfXjsrfIdtTv7BpnTPg=;
        b=jdyOLtn+cZCSzRvN8t270mN14H36rpk74XQqZkQnQ/a8gQFJypRiZ85IOpAlAxuKnJ
         pKfHDrEg9NQprxeQUJx87O6sTffJUx5jSSrHWk2Olnt7TMX0qgNqtPeqwvka3iUWCdZE
         trZOtisC4TpJe9EhYgmC7QMBuj7H6IMB9tnBV72HxgDvXEyBKm1LKDW4McujJ1KvNia4
         1mE/qNgniyqkRGSb2ZvX+jvxg7uvyJfutcbRa879tbVdgh06YGtEP4c5fyLELuPh3Xqr
         AzHvzWrk6YdqcTrmrg2tHpNqyCWv/kwasaMy36EiGL825WOHdy/tWFezNGfvGcqUy6um
         d7nQ==
X-Gm-Message-State: AOAM531Nn/pfGN/yNrkocXNiCrr4B5jRK76FNFX+3zvTw3RCptE3jWrU
        MQRN4XyqDRVOesf8aW0OkAY=
X-Google-Smtp-Source: ABdhPJxxdG2nk+CwJjiiihCedI+DGOKblWyDIk9ePkPDDptfOey/T/Ba8Y+wGz2vK+jLK+fVtymXyw==
X-Received: by 2002:adf:e792:: with SMTP id n18mr678450wrm.316.1607334661219;
        Mon, 07 Dec 2020 01:51:01 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id z21sm12985471wmk.20.2020.12.07.01.50.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 01:51:00 -0800 (PST)
Date:   Mon, 7 Dec 2020 10:50:58 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Allen Pais <allen.lkml@gmail.com>
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        ludovic.desroches@microchip.com, jesper.nilsson@axis.com,
        lars.persson@axis.com, horia.geanta@nxp.com, aymen.sghaier@nxp.com,
        bbrezillon@kernel.org, arno@natisbad.org, schalla@marvell.com,
        matthias.bgg@gmail.com, heiko@sntech.de, vz@mleia.com,
        k.konieczny@samsung.com, linux-crypto@vger.kernel.org,
        Allen Pais <apais@microsoft.com>,
        Romain Perier <romain.perier@gmail.com>
Subject: Re: [RESEND 17/19] crypto: s5p: convert tasklets to use new
 tasklet_setup() API
Message-ID: <20201207095058.GB13333@kozik-lap>
References: <20201207085931.661267-1-allen.lkml@gmail.com>
 <20201207085931.661267-18-allen.lkml@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201207085931.661267-18-allen.lkml@gmail.com>
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Mon, Dec 07, 2020 at 02:29:29PM +0530, Allen Pais wrote:
> From: Allen Pais <apais@microsoft.com>
> 
> In preparation for unconditionally passing the
> struct tasklet_struct pointer to all tasklet
> callbacks, switch to using the new tasklet_setup()
> and from_tasklet() to pass the tasklet pointer explicitly.

Wrap your commit msg lines as described in submitting patches.

With the commit msg fixup:
Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
