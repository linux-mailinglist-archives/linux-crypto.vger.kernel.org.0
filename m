Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9312123BA67
	for <lists+linux-crypto@lfdr.de>; Tue,  4 Aug 2020 14:33:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726086AbgHDMdM (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 4 Aug 2020 08:33:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726198AbgHDMcx (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 4 Aug 2020 08:32:53 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45128C06174A
        for <linux-crypto@vger.kernel.org>; Tue,  4 Aug 2020 05:32:52 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id p3so22008043pgh.3
        for <linux-crypto@vger.kernel.org>; Tue, 04 Aug 2020 05:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=benyossef-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WCt1TC78m72fl6dTikzGohA0nUGIaoTAmYoDfXqsjL4=;
        b=R4j1Kjfj+UuaGt1OvVDZ5l1lS5Korwa1Nu6LTjNO09fiKBg1eP+86tY9rf3ph4POVE
         9esQqoqqIUNdrK5+1pVRO7xxM8Bwpa7CsMm3bm2/6p5rcyuCniPSOaeDQ1VyqjyMBeST
         HSIWaNPPBcoFmsSykehGO19JRb5TuzTOSKhrfWHku/QRgBU7UEvXlvfx4GEvaOmDGeh5
         2/ZLUsJExVPF1zuTSS8pBdY6UiTqcaEf6/wNiLlUTTZA8wHi0q9qDqxmk2757knzVU+8
         JnHEIs0IgsBn+9j4h3vk6wS25XnoATNza2oV2IZlmHmKcuOF0+fygIFAIbl+3bPD4p5M
         b/Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WCt1TC78m72fl6dTikzGohA0nUGIaoTAmYoDfXqsjL4=;
        b=IuD7DE9hMfTlLRZOz9wF4fwOC3ecjMxLbPlJSLQ0J3ocbJC1SbS202NrrgLq1PqTmh
         TB7ogytBrMJqhUmiBRAio+1HO54FjWs+c/Msa3WN+QvAF6tlImMDvZoaDia1PQg5wEBb
         fPOE6J4pq/7UMJb29a0Km+gzIrHtHPjcKjzKSC3Hyb9XeMlNf34VpynK8q5yN7leEY0c
         uTOZ/WjfzfowTzKeKBk9syWTdvDtRtlkxJWA4QGyRO5wiua+NR6kFxEIavxVsLPr2Gu0
         w15Eq0d5kRNlVatZrAoUzTulNkOka8sCC6C6M1xTUkC8ScxVo1xEXMZ/3EgeoQJYmmlA
         bTYQ==
X-Gm-Message-State: AOAM533wLUS/PKbmrL6rtHPhCLWUduPIEXbTqQOa/sW6IINVH9KsRElZ
        fzeTPq/noHsf3/e1POi5twl+sVcFkK2dopSZF/KAmJiTFYg=
X-Google-Smtp-Source: ABdhPJw7yTQvVJJn7+x3+iYxaaV72XzAhOMDsGInJUPr4UEZB2NC/tWbxM+4RNXkTfZHvMLX4J2A2eJ5ORK8+wsot9A=
X-Received: by 2002:a62:78d6:: with SMTP id t205mr20818508pfc.68.1596544371674;
 Tue, 04 Aug 2020 05:32:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200728040446.GA12763@gondor.apana.org.au>
In-Reply-To: <20200728040446.GA12763@gondor.apana.org.au>
From:   Gilad Ben-Yossef <gilad@benyossef.com>
Date:   Tue, 4 Aug 2020 15:32:40 +0300
Message-ID: <CAOtvUMc-RnxJ2c=GaTpS5nNd0xjKqd1zyFPO=5_ANCzMYXFU1w@mail.gmail.com>
Subject: Re: [PATCH] crypto: ccree - Delete non-standard algorithms
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Tue, Jul 28, 2020 at 7:04 AM Herbert Xu <herbert@gondor.apana.org.au> wr=
ote:
>
> This patch deletes non-standard algorithms such as essiv512 and
> essiv4096 which have no corresponding generic implementation.

Sigh... yes, these were left in because I I thought it might be
interesting to bring support
for these algorithms (including a generic implementation) into
dm-crypt but alas, there seems
to be no interest.

If it's OK with you instead of this patch I'll send a patch series
that also removes the support for
these from the driver, not just the registration, as there is no point
in carrying dead code.

Thanks,
Gilad



--=20
Gilad Ben-Yossef
Chief Coffee Drinker

values of =CE=B2 will give rise to dom!
