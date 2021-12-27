Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C676147FBF4
	for <lists+linux-crypto@lfdr.de>; Mon, 27 Dec 2021 11:50:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233386AbhL0Ku6 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 27 Dec 2021 05:50:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232921AbhL0Ku6 (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 27 Dec 2021 05:50:58 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 285B5C061401
        for <linux-crypto@vger.kernel.org>; Mon, 27 Dec 2021 02:50:58 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id v13so13383465pfi.3
        for <linux-crypto@vger.kernel.org>; Mon, 27 Dec 2021 02:50:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:cc;
        bh=7f0Bjb4CTA9sDf/RhNU0ViDB8ImucRrQA+jdH+nCegM=;
        b=O6JZ5tJRGmh533LFC1F7VXVt+JW1EerUsizM2fx543eZntYjsw4XSnydoC0awuulol
         3JpNiJC9FTCrwIINt6AsrTTK5xVI4mDkWL1p3lETWLcOHp0CKu6ijW4taDDTeRzwSITK
         isWCgbM08UbMQcfL+eLMncmvE17vUQz94hbWRhyA6vlMhsyQXezg+682TqMgvK1DyBaC
         8/dLBBTWdlfqFHf+IQeiFaVFz4FjT1v8HUJeTDEE3JhpQiyrtBidsQ5cIvZGHulvFdCs
         gy0gTc6HUNlN+GWTjUFXtPT81nawMZOnu5BO5cHvo5sdrnvIBOitCWQMz7KAFmfh+T7g
         QKJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:cc;
        bh=7f0Bjb4CTA9sDf/RhNU0ViDB8ImucRrQA+jdH+nCegM=;
        b=qymjE2JkdehFJ3SElbjR7LgR2tSKFnT5OQsmU8rVpQoBwLH0XzFLqMO+LsXiJONLJJ
         YbpJ+kqFU9/p0yRFtUWDmVHlYkSoUQIE+9EoOL61/wX7wVtEYuKJQWfdopM57kP0pXuC
         /x9c6v+HKxR718rAOnrYgkEI/pUraQwFFs5kM+pFNs+THvr7eR7B8Skp8kMdH3mqp7dy
         DE1/rZNh/D82yk5yBI4/X6csLeL/VtXPRJ4OEvIfWJj0lSmswjr4VmGdJqb3Cv/yU7xI
         ZJ/Dz+5X+VAl38bD6/6bVYiPcyXnT177uZpW931ybzb6CcKGhoA0ropIOf1Vm5/cVYo6
         Zl/Q==
X-Gm-Message-State: AOAM533Agitt9cm0s5tZbHG0ZV7s6G5TKoG4x97AkXU1GRc8cVWxitAY
        WocRqj2SGKhbtYpDqCqdekHJWVnSdgRujgU0lZ0=
X-Received: by 2002:aa7:8b18:0:b0:4a7:ef66:3b6d with SMTP id
 f24-20020aa78b18000000b004a7ef663b6dmt15573210pfd.13.1640602257007; Mon, 27
 Dec 2021 02:50:57 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6a10:8e86:0:0:0:0 with HTTP; Mon, 27 Dec 2021 02:50:56
 -0800 (PST)
Reply-To: israelbarney287@gmail.com
In-Reply-To: <CAGMjROcosVYj0PUf1+d-pYwLicS9P7gvtwQ=JeUo-i3GDY-omA@mail.gmail.com>
References: <CAGMjROdAt+qmPXPBPeP88hDvOnswXk5MXi_unkzgK6nO5CziHw@mail.gmail.com>
 <CAGMjROf8wdQr9RSN73SuyteJVboNPFfz9gfun9tqCwdnjytznw@mail.gmail.com> <CAGMjROcosVYj0PUf1+d-pYwLicS9P7gvtwQ=JeUo-i3GDY-omA@mail.gmail.com>
From:   "Mr. israel barney" <sylvabou2018@gmail.com>
Date:   Mon, 27 Dec 2021 11:50:56 +0100
Message-ID: <CAGMjROdF_hw37=4UmjHHAMeBH1TEYd39XB4dADFA6Lu2D+RBOg@mail.gmail.com>
Subject: good morning
Cc:     israelbarney287@gmail.com
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Permit I talk with you please, is about Mrs. Anna.
