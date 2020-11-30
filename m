Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC67C2C820F
	for <lists+linux-crypto@lfdr.de>; Mon, 30 Nov 2020 11:24:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727696AbgK3KW7 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 30 Nov 2020 05:22:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:54196 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727942AbgK3KW7 (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 30 Nov 2020 05:22:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606731693;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AD2cHtU+nv97QOLLerTjSbz8BIGM/wyOf+Qai5nwNQE=;
        b=BZz/AYB0aEzEf8SYVjdjpz4zBqdSA8Q4LuK5M0wQI4t448+3UNoCRp9IFuW7oaGScuhLb0
        aibvpySUIa/OgPU/UfOJAhux7jiuzEJ1tUh5kyQhLvcw0C8akNcW4OaMqVzq4bzZBUanqX
        3DFFX5N6O0O8bha/4KR8mpHNHTbVqqQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-562-1o6NwjXwMqWdAqkgnQxPyg-1; Mon, 30 Nov 2020 05:21:31 -0500
X-MC-Unique: 1o6NwjXwMqWdAqkgnQxPyg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AF1911842141;
        Mon, 30 Nov 2020 10:21:29 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-159.rdu2.redhat.com [10.10.112.159])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0993B60657;
        Mon, 30 Nov 2020 10:21:27 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20201109135650.31831-1-dawning.pang@gmail.com>
References: <20201109135650.31831-1-dawning.pang@gmail.com>
To:     Dawning <dawning.pang@gmail.com>
Cc:     dhowells@redhat.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, tianjia.zhang@linux.alibaba.com,
        gilad@benyossef.com, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] include: crypto - remove the unused include
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3102891.1606731687.1@warthog.procyon.org.uk>
Date:   Mon, 30 Nov 2020 10:21:27 +0000
Message-ID: <3102892.1606731687@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

I've taken Tianjia Zhang's patch for this.

Thanks,
David

