Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36EA02DE6FE
	for <lists+linux-crypto@lfdr.de>; Fri, 18 Dec 2020 16:54:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbgLRPyU (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 18 Dec 2020 10:54:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbgLRPyU (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 18 Dec 2020 10:54:20 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BABDFC0617A7
        for <linux-crypto@vger.kernel.org>; Fri, 18 Dec 2020 07:53:39 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id 23so6537116lfg.10
        for <linux-crypto@vger.kernel.org>; Fri, 18 Dec 2020 07:53:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=MsKY7lPcgC80he04Y9/ViePpHODYf9q9tJhd7l/hLjY=;
        b=KjTzN3luOOtS8/8dgELyavgUyvd8WtkpGN3So/I6YbQG+kTo4uSZMzjD5k2LOW3fex
         lkz3MVWGpi8dEXHXDgRaxfJqVamU+17esrwQpGcq3BIt+lCR15zdJnksvPE6LSgYom+O
         OPBv32k3IjHrwKDQzMWkKkiBn7kmn47+BIV0/wC9v6Fljz5ES03pBxcPYrrYCCAs2wWv
         t1vPhb62qS7/6xz/eBx46CV5cB+MKghU5AO3OPVcWP1vyqqJ3KZ6f0oK8rjn9xWhY9VE
         UJ/XRpw/IYmWwBfOGtkc5u2m2RBBk9KL3EN5mnBa+GMwpOio4xZIAQytfvfqymK554mW
         tj5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=MsKY7lPcgC80he04Y9/ViePpHODYf9q9tJhd7l/hLjY=;
        b=eMIDAKdcdNfm3pPYaE8EzP40xthJxGt9WIXJTvF0jxibIvn71Lzzg4fDwiftf08lH2
         gaKIDerqU9UPz1gDimRZmFMj+FFL2FaHfRtLZv2eZYf/rLnrLPVwVlxmxc5M5+XBjd2i
         dfPLpWbQhHC5Dz+cq9PDF0VcEO5M5rwVlPcr7UtlNSZMPxyA1hv9kvLfmYNDBZ55Sd7B
         3jaGMxu1P/4df27/lIhyU7Vf2NG5pMGCuSokQZj6OmAZosNRMtDoTUV4CzqpZQmUzJgs
         xKRLIr/Zoekhi+vU9clD635ZDHbLH/D6aAKTKFhHZXaf9Wo6tZ20dmr9OeTmODJDCtuO
         9hTg==
X-Gm-Message-State: AOAM533BhXpvjAeJfN/2XQQNJGGrfrNKInWYtDqeP5p720UeJXl5tnIH
        zNO6fSzHZ5Y7Sru871EERE1+6pN4NfDNoupH82c=
X-Google-Smtp-Source: ABdhPJwD3/4XGTrB0jrJEB/60No4rrneG/Nqg3nrVPXKl948LkPlbgg4FCazy4kH040HyYjkfVEXcZsNtW9mFWfwNj4=
X-Received: by 2002:a05:6512:6c8:: with SMTP id u8mr1631396lff.172.1608306818269;
 Fri, 18 Dec 2020 07:53:38 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a2e:8850:0:0:0:0:0 with HTTP; Fri, 18 Dec 2020 07:53:37
 -0800 (PST)
Reply-To: jameskone@protonmail.com
From:   James Kone <kj000459@gmail.com>
Date:   Fri, 18 Dec 2020 07:53:37 -0800
Message-ID: <CAPYBfC6jguat-67zktNCmKcSona8kercakT2UJSj_Gy1TqN7tA@mail.gmail.com>
Subject: read..
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Greetings

Please, I want to introduce myself, my name is Mr. James Kone, a bank
accountant. I wish to know if we can work together, during auditing I
discovered a domiciliary account with a balance of 5.5M US dollar that
belongs to one of our foreign customers who died Misfortune on
covid-19. I contacted you because you bear the surname identity and
therefore can present you as the beneficiary to the inheritance. If
you are interested, kindly get back to me, so to enable me give you
more comprehensive details regarding this project.
