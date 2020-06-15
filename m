Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B44DF1F8EE6
	for <lists+linux-crypto@lfdr.de>; Mon, 15 Jun 2020 08:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728283AbgFOG6w (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 15 Jun 2020 02:58:52 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34371 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728276AbgFOG6v (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 15 Jun 2020 02:58:51 -0400
Received: by mail-wr1-f67.google.com with SMTP id r7so15863614wro.1;
        Sun, 14 Jun 2020 23:58:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=15pzvZ3HgzVpOIe1NSunNL4NazqLAoN4J8Q/f2NVLd8=;
        b=kJO4LvBPRRxzDW+hruK9cyPECKVXeUaSwoFgi+rt2G6j+lvqMywBKgbouLf/Eo2fOy
         NpyxzN1XfaIgdFRG5jULjxbGPCBbX4HODlf39u3MEvt14GwJ55uKeBypggTnNZ7vBCd0
         HGPkDqMSgwZxG/6ZlDE+KOz5E3m957i07jdGGGyKgyjHdNHlsVAvNeqBgFujfsnJJQpb
         ijW+HdEUM6Ys8hizKHPZhkPKBRO7NI348HpK8s/0W94RxXbmOXuQIP8N7zZI4I5sWSxD
         xU3jbcyUWF4nBN4mhDKyeLdsSqswK3xq51Y9iPsRHZqTYMcFh0LJxR47A7uDRKdIAOGA
         gGug==
X-Gm-Message-State: AOAM530Ug/mBhDx99ZzCAvVdxySQtHBGrpPVy9akjY7ZLvcOEqATSO1d
        3aL/+pj7KFtMQjX3lycC8ig=
X-Google-Smtp-Source: ABdhPJxC3uTidSFQuPJd5N+ZIugAF5DjMqJZwBdBMRxo/CsJfJGnW54QJwO/PEzPpqMarcPL1KnxUw==
X-Received: by 2002:a5d:5585:: with SMTP id i5mr26775604wrv.112.1592204329345;
        Sun, 14 Jun 2020 23:58:49 -0700 (PDT)
Received: from kozik-lap ([194.230.155.184])
        by smtp.googlemail.com with ESMTPSA id d63sm22195666wmc.22.2020.06.14.23.58.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 14 Jun 2020 23:58:48 -0700 (PDT)
Date:   Mon, 15 Jun 2020 08:58:46 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     wu000273@umn.edu
Cc:     kjlu@umn.edu,
        =?utf-8?Q?=C5=81ukasz?= Stelmach <l.stelmach@samsung.com>,
        Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kukjin Kim <kgene@kernel.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        linux-samsung-soc@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] char: hw_random: Fix a reference count leak.
Message-ID: <20200615065846.GA5791@kozik-lap>
References: <20200613214128.32665-1-wu000273@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200613214128.32665-1-wu000273@umn.edu>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Sat, Jun 13, 2020 at 04:41:28PM -0500, wu000273@umn.edu wrote:
> From: Qiushi Wu <wu000273@umn.edu>
> 
> Calling pm_runtime_get_sync increments the counter even in case of
> failure, causing incorrect ref count if pm_runtime_put_sync is not
> called in error handling paths. Thus replace the jump target
> "err_pm_get" by "err_clock".
> 
> Fixes: 6cd225cc5d8a ("hwrng: exynos - add Samsung Exynos True RNG driver")
> Signed-off-by: Qiushi Wu <wu000273@umn.edu>

1. Cc: <stable@vger.kernel.org>
2. Subject prefix:
	hwrng: exynos - 
3. Subject title: Fix PM runtime reference count leak
   (no need for end stop)

With these changes:
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof

