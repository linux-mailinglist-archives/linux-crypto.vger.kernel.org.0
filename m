Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3674A6A94B4
	for <lists+linux-crypto@lfdr.de>; Fri,  3 Mar 2023 11:02:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbjCCKCU (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 3 Mar 2023 05:02:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbjCCKCR (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 3 Mar 2023 05:02:17 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4E8830B2B
        for <linux-crypto@vger.kernel.org>; Fri,  3 Mar 2023 02:02:16 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id o15so7917294edr.13
        for <linux-crypto@vger.kernel.org>; Fri, 03 Mar 2023 02:02:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677837735;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hEweQgAYTFTI5lRg9e3VihMmMHbzOsZa8+jPeRmAFV4=;
        b=sc3u9LlO/XdKRkWyyz49VTzI1aK1BNDAuPVN3ZvX/yyIjSOwiCYrZfmz2ZEL07k+rQ
         2/dgkYPACoseyZloA6wBD6BMlpDii1laL3W0Il7OT1oGle0KseSbTiaL/paXZfd666JJ
         hbJv2Wb4Ep5Ob1t0Y9iIA797jr1N/QPOvvPg/VyYdu6SKzKQDSK6XDh71ntInPjAGRuG
         MgaoqRASTqGuKRG5g32BNh6BktBRvJRaSslg3wYAStvtFxtx54ndisKnVKzRIPe2w0of
         0p9MPLrb5ndjV9vjuCNi96Bq5xtMfZ3kSXFmyzI8R+nqnX8yK932ZgTR2JqjBA4tErpW
         Gpfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677837735;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hEweQgAYTFTI5lRg9e3VihMmMHbzOsZa8+jPeRmAFV4=;
        b=hLwOZPKja0XXW3cO2LPm6t5H8h839Q7KLkRdybOF6mH2dg7JL7hkFr/P/0ByvAy/Iy
         LdsrGlOtWfIqc2ozR+Y5V+f/qpoUpyJTO10Vgs23Vvt2dpnpVqfSL2186CCJX2rZ88Yj
         bewBdPzeRcboFN9iGbQVsKumwiKkaae9rjIdfwS8pp+Gmj2QDHasRYXv5jYBUTc2QFL7
         OaIBZMidPgfxLk/sWN9zq28yS/Rd3MZLTjIHV/pqNOhCnt+FEY0F0HE2pjXfziFnCKd8
         tFd+m7U0AdRKB8kpLwFsp1Ssxp536A1LfJiHhi/yGQH5ZGWA7tjNl0Vy6z1AjZCn3e0H
         BSrg==
X-Gm-Message-State: AO0yUKVNKBfiQGecSwmxVVEWsXECPPC6rtOINiCZ1m0Z0EQ4MJG2ycCD
        LreuObV+IXGkuQ1PSLiEPiBWPg==
X-Google-Smtp-Source: AK7set8N788FOZy8TJzMOhbmGsv6nTKqhz1lIxT9d9otKAYpRa0Fv06gvACL+GXzj++IZk4PqdKoVw==
X-Received: by 2002:a17:907:97d3:b0:883:b1b4:e798 with SMTP id js19-20020a17090797d300b00883b1b4e798mr1263546ejc.10.1677837734553;
        Fri, 03 Mar 2023 02:02:14 -0800 (PST)
Received: from [192.168.1.20] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id o18-20020a170906769200b008dedf1359a0sm782626ejm.104.2023.03.03.02.02.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Mar 2023 02:02:14 -0800 (PST)
Message-ID: <b5aab510-30ff-0294-315d-509d88853eb1@linaro.org>
Date:   Fri, 3 Mar 2023 11:02:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 7/9] dt-bindings: crypto: drop fsl-sec4 txt binding
Content-Language: en-US
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        horia.geanta@nxp.com, pankaj.gupta@nxp.com, gaurav.jain@nxp.com,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, stefan@agner.ch,
        linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Peng Fan <peng.fan@nxp.com>
References: <20230301015702.3388458-1-peng.fan@oss.nxp.com>
 <20230301015702.3388458-8-peng.fan@oss.nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230301015702.3388458-8-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On 01/03/2023 02:57, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Since we have convert it to two DT schema, fsl-sec4.yaml and
> fsl-sec4-snvs.yaml, this txt binding could be removed.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

No. Conversion includes parts of removal. Don't split logical commits.
It also makes review difficult.

Best regards,
Krzysztof

