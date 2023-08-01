Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7782376ADC3
	for <lists+linux-crypto@lfdr.de>; Tue,  1 Aug 2023 11:33:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231678AbjHAJdk (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 1 Aug 2023 05:33:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233015AbjHAJch (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 1 Aug 2023 05:32:37 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0B3846BD
        for <linux-crypto@vger.kernel.org>; Tue,  1 Aug 2023 02:30:42 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id 5b1f17b1804b1-3fe1a17f983so21815485e9.3
        for <linux-crypto@vger.kernel.org>; Tue, 01 Aug 2023 02:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690882231; x=1691487031;
        h=reply-to:date:to:subject:content-description
         :content-transfer-encoding:mime-version:from:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ANXExHiurpsLW1+AnLl79UdLdXb9JEMrjqkSigWkyLQ=;
        b=Sj9kHPKsiH24jRpUzVNEPiXrJV7rimsjECl6zcxjo6zj1LYpCZukT+gqMYUN6YCb3J
         G3Dpg/Yh1xgV0ta4NPlPh35m1SZx2zrNngPPI1FB04g/AX7XluI1bJcg+aBWsQRhmw9m
         zY8nm/jRAAu/VQjwylan2odI2W2MK2gtd8jweGb3dJ3/4m30Rd8u0g7NuJHQXUeAX+2e
         Zpa7JeXxfJX/qX3doT8PPkFbsLEkopugDTjn5dMhqOErcTxXPkGsxPBojUbHYgTjR3U0
         B8Jv8t2yCsgMRZDpc6QChaurucUrCsVjzhRWHl7X5XnXC2K3CN9fKuOoLNDi5VmQRbEl
         YmRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690882231; x=1691487031;
        h=reply-to:date:to:subject:content-description
         :content-transfer-encoding:mime-version:from:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ANXExHiurpsLW1+AnLl79UdLdXb9JEMrjqkSigWkyLQ=;
        b=VQUhKQnV15JG/RY8hldxZ+Hl1yMr6Dz+rp/lxwPg9I8WMOjjfv5/WiXnwMTHk9g4Rr
         TUonHky7p3l3EGJk7Xh65yPFdDGJz6kOS+VX+HR2oQsrkgsxSGXH3yesFMqVULhcSZS5
         ONPrJJnnbdEoncu7WYCs4hjaep8bCZZFIBIh9F63qp5pQ6WREjkMTppBHXWsQd69QnUC
         gZgPiLaVbFMC8fh4OgE61SRPKR1N39A86C7w3GgkWtAa1vsmg2PjhEA6T4e+LrgOe6i9
         jPuhzhSsOMMzgbC70b01ztGRIRS4qz1gO6gT8SOMLOYeGMR+XnuBI0vKfIEB8hdys39w
         Sg+A==
X-Gm-Message-State: ABy/qLZVAsWQFc6BuxcGAsczIGlZEGDOgPHTM1GPTzTr6rAOI9/5n0rL
        XP1sURPnDMCECrnTzu9Ggf1BScYfiTW5/A==
X-Google-Smtp-Source: APBJJlFgkwfg2qpuzqtSQ9VfNppOxJxmCB4RKKTPKUQglCC3ops0N9dANtQK6UbN4hM3VMwnPvk3Wg==
X-Received: by 2002:a1c:f019:0:b0:3fb:b5dc:dab1 with SMTP id a25-20020a1cf019000000b003fbb5dcdab1mr1738941wmb.39.1690882230549;
        Tue, 01 Aug 2023 02:30:30 -0700 (PDT)
Received: from [192.168.1.102] ([91.239.206.92])
        by smtp.gmail.com with ESMTPSA id n20-20020a05600c3b9400b003fd2e898aa3sm1380848wms.0.2023.08.01.02.30.28
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 01 Aug 2023 02:30:30 -0700 (PDT)
Message-ID: <64c8d0b6.050a0220.e1730.546c@mx.google.com>
From:   World Health Empowerment Organization Group 
        <petricaluchian839@gmail.com>
X-Google-Original-From: World Health Empowerment Organization Group
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: We have a Job opportunity for you in your country;
To:     Recipients <World@vger.kernel.org>
Date:   Tue, 01 Aug 2023 16:30:20 +0700
Reply-To: drjeromewalcott@gmail.com
X-Spam-Status: No, score=2.0 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,TO_MALFORMED,T_FILL_THIS_FORM_SHORT,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Greetings! Sir /Madam.
                   =

We are writing this email to you from (World Health Organization Empowermen=
t Group) to inform you that we have a Job opportunity for you in your count=
ry, if you receive this message, send your CV or your information, Your Ful=
l Name, Your Address, Your Occupation, to (Dr.Jerome) via this email addres=
s: drjeromewalcott@gmail.com  For more information about the Job. The Job c=
annot stop your business or the work you are doing already. =


We know that this Message may come as a surprise to you.

Best Regards
Dr.Jerome =

Office Email:drjeromewalcott@gmail.com
Office  WhatsApp Number: +447405575102. =

Office Contact Number: +1-7712204594
