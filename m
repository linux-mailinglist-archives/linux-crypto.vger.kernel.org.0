Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E3C060847E
	for <lists+linux-crypto@lfdr.de>; Sat, 22 Oct 2022 07:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbiJVFVK (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Sat, 22 Oct 2022 01:21:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiJVFVJ (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Sat, 22 Oct 2022 01:21:09 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51D2E232E62
        for <linux-crypto@vger.kernel.org>; Fri, 21 Oct 2022 22:21:07 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id l32so3505876wms.2
        for <linux-crypto@vger.kernel.org>; Fri, 21 Oct 2022 22:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=u1QxIMNvQ/igMVvDHSj1Y7sv0nIazZvN83miuicXzAU=;
        b=GLprcfNkb4YTu7nYxo9CPlsqW6u06zhE/xMrXpFrqMCQ22jLA4qi14a1oZRdqIj4hx
         +OgeMnz5yet+NnBFNdmCtG6X9cOiaxoUnvm86f+TpzeF59p1RHZ81nD5skgv1+27wMU2
         zs0yUtpWfaXiPoGmLfWtkNW7oyHV5g6IFAvACjt3HunSy9kxcTUfw6j1T21fJRlMTllI
         /+nNCG2yFH5mXmWQykv3ivmzXmjTrbUMC5Y3d7olC0E3tmfAWoQoMT85rgngkWwG0vFN
         CyhVR0DNechYqEHDXhvFFySpsww3pHeyDQo3jAfWlsCg7CSQknTV5cN+VvRJ4nzHc3bs
         nVuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u1QxIMNvQ/igMVvDHSj1Y7sv0nIazZvN83miuicXzAU=;
        b=ra7o37XjhbN25IeKkQ8+m2znmCAK2bRT+NpbrEayQQyxeVFQGmVRz74gh/MpQJBDMy
         RrH64FIzIFwYCISlnjpaEVjEJxtijIaPjBgZTE+Jjw0dq0/4ktRFJaVv2T2y74NoBPCO
         zrOeI8loGp53vhbzvoolAVeuJ7QTGQgHLc8kqq40fC6l9K2uvzwV1UKd+My/Ll9qoCbh
         SXkb6NTNmoxM8AYtK6D66dxBhpCJiLMIxQuwL6Q4Z1E6r1Wfxf0lKwAQNOGDKqR04qQY
         7/BvZom1vP9wt0kBL4NYY9bSui0tGkDIvIgVPfeUYOzTrCHs/bNYESJ3WbpB+kYKjw06
         navg==
X-Gm-Message-State: ACrzQf1PQso6HlVvO+YPlUKoC4k47T9lRcgreNVlI6d6jPhV9mgHP/nG
        zx+rdDMIpeKAH0AoxhybeXLcua8A6CEOSVt0c9pAE5Cm
X-Google-Smtp-Source: AMsMyM6KSk+07dQcfaidHl9bHgkbkMS6Q1V+3y7IZ5hP/FtbJ9lckYC/6kKo0Ts/xoJEnvqG1dDi73MF9v5YnbcSFck=
X-Received: by 2002:a1c:f60d:0:b0:3be:708b:c96c with SMTP id
 w13-20020a1cf60d000000b003be708bc96cmr36994570wmc.168.1666416065442; Fri, 21
 Oct 2022 22:21:05 -0700 (PDT)
MIME-Version: 1.0
From:   Travis Geery <geerbot3@gmail.com>
Date:   Fri, 21 Oct 2022 22:20:53 -0700
Message-ID: <CA+mLQwCsVfupJSkHjxZ_tSfoF9GmuUmP+H5xgrFuuBdMVU6H1A@mail.gmail.com>
Subject: 
To:     linux-crypto@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLY,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        TVD_SPACE_RATIO autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

unsubscribe linux-fsdev tpgeery@gmail.com
