Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 943ED3587D9
	for <lists+linux-crypto@lfdr.de>; Thu,  8 Apr 2021 17:08:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231945AbhDHPIW (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 8 Apr 2021 11:08:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:58539 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231843AbhDHPIW (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 8 Apr 2021 11:08:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617894490;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SRK35NZb8F0GlyP9zPwaWoJ38d3PF8a3EWrwShnrRxY=;
        b=RQ2WSoZpsKxOBeLur/YhES0oZ+WKqMkXiegm2/mKivVSfzxnNRenc+8YLjJ5KcC0S0U+ip
        g2huFYBuVzMvTCFELNnrfYRrVfYlDJOxtyn112gvY1t6OsmgtwYJPEUmcNXSzWbtX3a0BP
        2NcoHEIe4k+RU/ar5v8OdDtCA59x2s8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-2-Zj79LQ1EPX61PwRan7PMyQ-1; Thu, 08 Apr 2021 11:08:08 -0400
X-MC-Unique: Zj79LQ1EPX61PwRan7PMyQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4DF0C56C9F;
        Thu,  8 Apr 2021 15:08:07 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-119-35.rdu2.redhat.com [10.10.119.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6A6F260636;
        Thu,  8 Apr 2021 15:08:05 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20210408141516.11369-1-varad.gautam@suse.com>
References: <20210408141516.11369-1-varad.gautam@suse.com>
To:     Varad Gautam <varad.gautam@suse.com>
Cc:     dhowells@redhat.com, linux-crypto@vger.kernel.org,
        herbert@gondor.apana.org.au, davem@davemloft.net, vt@altlinux.org,
        tianjia.zhang@linux.alibaba.com, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org, jarkko@kernel.org
Subject: Re: [PATCH v2 00/18] Implement RSASSA-PSS signature verification
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <13251.1617894484.1@warthog.procyon.org.uk>
Date:   Thu, 08 Apr 2021 16:08:04 +0100
Message-ID: <13252.1617894484@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Varad Gautam <varad.gautam@suse.com> wrote:

> The test harness is available at [5].

Can you add this to the keyutils testsuite?

https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/keyutils.git

David

