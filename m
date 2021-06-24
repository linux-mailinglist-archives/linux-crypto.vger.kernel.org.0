Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D7873B3459
	for <lists+linux-crypto@lfdr.de>; Thu, 24 Jun 2021 19:09:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232064AbhFXRLq (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 24 Jun 2021 13:11:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbhFXRLo (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 24 Jun 2021 13:11:44 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F350C061766
        for <linux-crypto@vger.kernel.org>; Thu, 24 Jun 2021 10:09:22 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id a11so7097821ilf.2
        for <linux-crypto@vger.kernel.org>; Thu, 24 Jun 2021 10:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to;
        bh=ANhbTggsY3NFhRZExKMwUmb3VzJqye8XLvWVXSvNBkQ=;
        b=p95plxgcKdT8+TUJCmcKdAyJL6L8C+j3muAeTI6tbvEOMwKUFZvBH22Z3GEGxdnUZH
         d9XkDasjcz/bUj2n1PkWxPPQL/Sxtf1a7ckN43IkWwU4a9v6DYeOi9Tg8DPYHl700hH/
         xlmv54Ir2NUVB8zwaX1UsxTzP5GUW3mdywmszCeflzWKbXzDgkMNhx+qVsi3FklHnD5x
         fSDWvxz3POXOJ/0yZM+F2G99rPMTFJK+bPA5TWYu0VJpvpEjmQwRSgXLB6dx+kXpC0Uz
         JX+JhI0lSB7VkwJTdkbApCrUx6TGzp99N5mAm/d0lil4hmexz93RFAPSpMzmwkjNchKB
         rXTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to;
        bh=ANhbTggsY3NFhRZExKMwUmb3VzJqye8XLvWVXSvNBkQ=;
        b=tOslLqi3JfM7pf60t0ppEQstkw4TwqQqzzwzi0g/Xpg2RwTW5yjXmHrbX8kqzC0w8K
         ZnnxqvdRfhT5DU6ttKOgNshs+Z3bnRa9Ej6MhqJfreZ9L/oPH37TTUrvzHh5d7Imf7MH
         CPpFqwqHWdOIC1E89f8cEZfTuu35TJ0xVw5Y6ImcHhfsc4avn6lGrYsrzDHvCEKuV9w8
         wALHacCYexdHrTwquJra4es2k92kkFAQEHk2WQh2BcNlfy6zAixlorzgOutKlFxAx37i
         Kjw/6bQqTQG6ic1iJmTtFM7zI14gvEc27B3Xo1YQq5HJDBqNong536I2hcYQbxK5wh4R
         F20Q==
X-Gm-Message-State: AOAM531XWDAVP94P9na0QZjXVry8v8pS6MYxKwMTy6xP7N2yUnPmSuq/
        HVKGxIP5AgnElku7YCXW4mkfOJNzSbfJ59S76PU=
X-Google-Smtp-Source: ABdhPJzkYUuO368jts0QgMQyJe9SHzg0U698qd8KdfojEfYsXnHtwMfPGxVHmw7fwQ64+IhHRhAEJH5nusdeW4BWzcA=
X-Received: by 2002:a05:6e02:524:: with SMTP id h4mr4098121ils.255.1624554560853;
 Thu, 24 Jun 2021 10:09:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6638:3aa:0:0:0:0 with HTTP; Thu, 24 Jun 2021 10:09:20
 -0700 (PDT)
Reply-To: tutywoolgar021@gmail.com
In-Reply-To: <CADB47+4Wa3T59Vq_==GTXEfHrX5x-2vQFxaTBO0dTdyAweCVpw@mail.gmail.com>
References: <CADB47+4Wa3T59Vq_==GTXEfHrX5x-2vQFxaTBO0dTdyAweCVpw@mail.gmail.com>
From:   tuty woolgar <faridaamadoubas@gmail.com>
Date:   Thu, 24 Jun 2021 17:09:20 +0000
Message-ID: <CADB47+607zNBfYFb4bj0nUhuuYgAdwT=G_wJ9-EeV0ESHe56Jg@mail.gmail.com>
Subject: greetings,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

My greetings to you my friend i hope you are fine and good please respond
back to me thanks,
