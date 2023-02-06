Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C17B68C4D3
	for <lists+linux-crypto@lfdr.de>; Mon,  6 Feb 2023 18:30:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbjBFRam (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 6 Feb 2023 12:30:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230255AbjBFRaf (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 6 Feb 2023 12:30:35 -0500
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AABA2A243
        for <linux-crypto@vger.kernel.org>; Mon,  6 Feb 2023 09:29:40 -0800 (PST)
Received: by mail-qt1-f178.google.com with SMTP id g7so13641344qto.11
        for <linux-crypto@vger.kernel.org>; Mon, 06 Feb 2023 09:29:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w/LaKIf+3pRA4MyQMhbr3PlVOqptn/pf/udFxon0+9Y=;
        b=jv0tFUL6vzFxMZ2axX+yWPoUwwA7AAOj4T7U2tE0EKhh6o1J9WnlhvOMIPsWNI2+Ig
         WlEHDLZUXDwz8lqr2Eksk++nqsr4r5DW6atMLfm1ZufNeDj8tmXF7kf9F1cMkqYBYA+C
         gn0vy4xe4k4cWxcUG34jL8NnKZE7elidFH9dQFlXqh38u/aoUaoPgTQun+6If1afYSr9
         RRldtvJSWZpB77u5J9lr3hvjw3EAHG+Y/ObDO5AITF3R/ijIIYOVioCEZ+Imi3j7aBGq
         ejOL4UYYLMJaBwXINRVXLtPmS9wf/iimDA8yrC+ge36FpBkuHHBKiXONvOIpe9XVAkVZ
         TuFw==
X-Gm-Message-State: AO0yUKWD5hv0jkIQbcl+7ReDpUFhZUZkGiq9q+zknnafRFB0qKg3xbbl
        GS1uLfafORPJQJS6bw6VSGVw
X-Google-Smtp-Source: AK7set/ae55jb9i/baaW/xLk4b7RJtQzOV+41D/ChSc6zOFdBQ9usaCQZSB0nyipHZthrt6kgVy39g==
X-Received: by 2002:a05:622a:c7:b0:3ba:1398:c68d with SMTP id p7-20020a05622a00c700b003ba1398c68dmr150769qtw.16.1675704579799;
        Mon, 06 Feb 2023 09:29:39 -0800 (PST)
Received: from localhost (pool-68-160-166-30.bstnma.fios.verizon.net. [68.160.166.30])
        by smtp.gmail.com with ESMTPSA id b13-20020ac844cd000000b003ba1ccba523sm3956815qto.93.2023.02.06.09.29.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 09:29:39 -0800 (PST)
Date:   Mon, 6 Feb 2023 12:29:38 -0500
From:   Mike Snitzer <snitzer@kernel.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Alasdair Kergon <agk@redhat.com>, dm-devel@redhat.com,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        Tyler Hicks <code@tyhicks.com>, ecryptfs@vger.kernel.org,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Jon Maloy <jmaloy@redhat.com>,
        Ying Xue <ying.xue@windriver.com>,
        Boris Pismenny <borisp@nvidia.com>,
        John Fastabend <john.fastabend@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>, keyrings@vger.kernel.org
Subject: Re: [PATCH 11/17] dm: Remove completion function scaffolding
Message-ID: <Y+E5AkiVTbjgXWjs@redhat.com>
References: <Y+DUkqe1sagWaErA@gondor.apana.org.au>
 <E1pOydu-007zio-0W@formenos.hmeau.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1pOydu-007zio-0W@formenos.hmeau.com>
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Mon, Feb 06 2023 at  5:22P -0500,
Herbert Xu <herbert@gondor.apana.org.au> wrote:

> This patch removes the temporary scaffolding now that the comletion
> function signature has been converted.
> 
> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

Acked-by: Mike Snitzer <snitzer@kernel.org>
