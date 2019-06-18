Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 076AC4A9A6
	for <lists+linux-crypto@lfdr.de>; Tue, 18 Jun 2019 20:19:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729964AbfFRSTY (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 18 Jun 2019 14:19:24 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:38412 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729868AbfFRSTY (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 18 Jun 2019 14:19:24 -0400
Received: by mail-yb1-f194.google.com with SMTP id x7so6456506ybg.5
        for <linux-crypto@vger.kernel.org>; Tue, 18 Jun 2019 11:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bNFiBDocFrqHhDhaPZDBNQocsZmJnCkhJmp1vP0eAbE=;
        b=ZbDwJhp88D9SzdOXhv96LD8nH13jyC4TAVVhfqRqxgpChwKTwVNudJkpH/G10GA4+J
         8nF31qcCc+gbNa0c+D7dhSnzUVCCg+cUah+4403g5PqcSC0ig7t0v/ZDuoPZ/6Q95d9b
         qSQVWMvIBh/aZ4JAmr27CFH7Borf7Uh9A7PKFmEy9ooVgJhoRccACyny7EQ8vfXIxQ6Y
         Fi3bQXVjw+/O6p4Q0sV0GcCDBdtOD6aMJkQE/+hF3WvQgIuaXdudl4qWp58VJWHWgTIf
         9544cFaoPyb/aR+YVO6ipqf7CdDW6VkpAD770X5vUYqKaaAIDOOwj0H7Ck2UIHq4jOti
         xlpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bNFiBDocFrqHhDhaPZDBNQocsZmJnCkhJmp1vP0eAbE=;
        b=NFlFlY4fkRAHZ7buWKS2UCrIMXv3WBSsxzou6hyM6N5QZ1oKV5nTF0B27IdTeD7mVQ
         Cgob7TXBPAJQ5owjF/KTM1OLly7Z0hKHzXa+i6geDxleALND36LAnDRpbJ9A/NjXauy5
         1C3qGh+Tyfmyq5ChguN4ZAMLzMnUqSM+GbDhgVDnOjA58qIMihOEiB+Au3cj2y8omw8g
         6jZhKprjmvl3nu9Myo3FXZBSgKsbsCsV+OtPuYt7p9RWsHVF9FGYP0Jfnq1vdm80KD8I
         v43xQi/zNUudFk+NqvL7ol3rrNF4rYDrvKpRPuewUUgeJItxu5TTw5XqrMGtT4Xlt69O
         CPWA==
X-Gm-Message-State: APjAAAXAACnQ3u7AA2Kc34IcvERM/WawsF83A9KcA3jSsG4jO5FSasjL
        Vtljmuq11+gtRkC4RwU56vsZE+wESHiQlmS3CkXDHw==
X-Google-Smtp-Source: APXvYqyykA7m2riwzq+t1a+jY5eL5cv+IYx4mLHAXrBc/xa56KnOBHebFrU6Gs1du0ZlmiN6deXCtB+os27OggQwCns=
X-Received: by 2002:a5b:c01:: with SMTP id f1mr58841259ybq.518.1560881963087;
 Tue, 18 Jun 2019 11:19:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190618093207.13436-1-ard.biesheuvel@linaro.org>
 <20190618093207.13436-2-ard.biesheuvel@linaro.org> <CANn89iJuTq36KMf1madQH08g6K0a-Uj-PDH80ao9zuEw+WNcZg@mail.gmail.com>
 <CAKv+Gu894bEEzpKNDTaNiiNJTFoUTYQuFjBBm-ezdkrzW5fyNQ@mail.gmail.com>
 <CANn89i+X7YQ6DueDQAusA+1S5Kmo75OwzO+eYRZe_nR8=YWjuQ@mail.gmail.com> <20190618181804.GJ184520@gmail.com>
In-Reply-To: <20190618181804.GJ184520@gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Tue, 18 Jun 2019 11:19:11 -0700
Message-ID: <CANn89iKCGPM03L2dE60VWOfYwbiHj1vRAXvqZuts0Ce-VdpifQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] net: fastopen: make key handling more robust against
 future changes
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        netdev <netdev@vger.kernel.org>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        David Miller <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Jason Baron <jbaron@akamai.com>,
        Christoph Paasch <cpaasch@apple.com>,
        David Laight <David.Laight@aculab.com>,
        Yuchung Cheng <ycheng@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Tue, Jun 18, 2019 at 11:18 AM Eric Biggers <ebiggers@kernel.org> wrote:

> The length parameter makes no sense if it's not checked, though.  Either it
> should exist and be checked, or it should be removed and the length should be
> implicitly TCP_FASTOPEN_KEY_LENGTH.

Sure, please send a patch.
