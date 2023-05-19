Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDA15709622
	for <lists+linux-crypto@lfdr.de>; Fri, 19 May 2023 13:18:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231712AbjESLR7 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 19 May 2023 07:17:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231656AbjESLRr (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 19 May 2023 07:17:47 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36886E50
        for <linux-crypto@vger.kernel.org>; Fri, 19 May 2023 04:17:44 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-969f90d71d4so480047966b.3
        for <linux-crypto@vger.kernel.org>; Fri, 19 May 2023 04:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684495062; x=1687087062;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YmxaI1amCfTksu6ynk2557PwK0HJxrBQmYIx/Pz5hBs=;
        b=JSg3rdU6W2mjqmEc+mB2A7cFmRegMCR83SHfOjxmRVbwY2A7mgymSN+oh42ISHBfwO
         GhYoUeZQdTAgrrktfs4VHXg5wvlxv+psdIxXqG71lRhZUTeGY0gkCC1W0WGnQ2KuhHot
         +NPDFYfn4R+L8OP+VhWdlcDsDSc9o5ruZin0Jy7jEd2WIJigUk3W15VR/5RcuFsK0DW/
         FpfL86ckeVx6y5Gc/4Q2cQwsXt6HqauHnQBLsDdwzZSaOMbN/NAWKn10V/OC4oS8nobW
         BkYyI389vonSGsu8g2o2QiZVmSCS1RCYF7e1+Ah3/AvqFMUnq3kHlvS8oKVbVQM9I4Wp
         NQBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684495062; x=1687087062;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YmxaI1amCfTksu6ynk2557PwK0HJxrBQmYIx/Pz5hBs=;
        b=K9QkKKVfv9xcJJWksJfcfv66O+6z98MQaT3RNM2FOl7WOIw+YlT+jUObC+GOHNbCSo
         sxez9QYZUloSsLGJDKY4yWeCLoVbD9ZhUeXbFErk/Pijypf5yMd2sjUoMNc/tABRivEQ
         qTHDDzbaGasHCC15arefdKjphJx3FKUsRJri7lX8Iial3pXDPqwIBxsldAqaxj/9K3c/
         K/ki+1sXYGBnhOp/JAD7+2V9c15YuL9ZSWXoRc+QalzVrIxoijAFUtp4cnhtOf5W5DWX
         BzBPfReHeg+HSQwk+IaIkRHpSYTGaaWetCqN7k8qdx9LJsvO0TxvBcaoKxf1EmBZvVBg
         TZlA==
X-Gm-Message-State: AC+VfDyjO8UkcH5zt2TZFg5o/24CS3u/0Po1lmLNHo3JiqbS6nfaWEgL
        b7BNZxRYaKbZuiwm6SideOeRYPNpLFKA20uBHsc=
X-Google-Smtp-Source: ACHHUZ4GcdKjctEWmkMJD/Q5ZDCusH7zrjV+w4c4EgP8GDbM+BMa7NNuPpP4cOMUW2oAUk/kOHHzW6hqw5zKR98kQX0=
X-Received: by 2002:a17:907:1b12:b0:8b8:c06e:52d8 with SMTP id
 mp18-20020a1709071b1200b008b8c06e52d8mr1298232ejc.36.1684495062361; Fri, 19
 May 2023 04:17:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:907:7dab:b0:94f:7d03:8e8b with HTTP; Fri, 19 May 2023
 04:17:41 -0700 (PDT)
Reply-To: ninacoulibaly03@myself.com
From:   nina coulibaly <ninacoulibaly199@gmail.com>
Date:   Fri, 19 May 2023 04:17:41 -0700
Message-ID: <CAM7Z2JAd00KW6b=O8M27vwRnsJ1w3AmDO5tP+gSmzkaHvk6=CA@mail.gmail.com>
Subject: from nina coulibaly
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Dear,

Please grant me permission to share a very crucial discussion with
you. I am looking forward to hearing from you at your earliest
convenience.

Mrs. Nina Coulibal
