Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E518D23BC39
	for <lists+linux-crypto@lfdr.de>; Tue,  4 Aug 2020 16:34:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbgHDOdP (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 4 Aug 2020 10:33:15 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41924 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729150AbgHDOcq (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 4 Aug 2020 10:32:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596551550;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Nw4Y7Dg01SFWbWmvQxGicDfAFpB/UkF2qnoLKbxXRMU=;
        b=Ox1fKg1vs4GIEPDaEpcihM0EtPB+RTvztYAMNMFovqmEdtfLF7mPM9+refRA5pUQNcFC9s
        Be6lNDoCYHY8DrhRj1czXYxdFZpwV8J9w0oHftWxXNYaunh/iqTcxrkbn7kJ1MsUEJS+lk
        9s7Qe+VTzK58qZmrxl34xp89vZTrlis=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-220-KhAxT_tIMjCJ7kbSK1m4iA-1; Tue, 04 Aug 2020 10:32:28 -0400
X-MC-Unique: KhAxT_tIMjCJ7kbSK1m4iA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 67F1D10CE78B;
        Tue,  4 Aug 2020 14:32:27 +0000 (UTC)
Received: from gondolin (ovpn-112-169.ams2.redhat.com [10.36.112.169])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5CAB05DA76;
        Tue,  4 Aug 2020 14:32:23 +0000 (UTC)
Date:   Tue, 4 Aug 2020 16:32:20 +0200
From:   Cornelia Huck <cohuck@redhat.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v2 08/24] virtio_crypto: correct tags for config space
 fields
Message-ID: <20200804163220.51081901.cohuck@redhat.com>
In-Reply-To: <20200803205814.540410-9-mst@redhat.com>
References: <20200803205814.540410-1-mst@redhat.com>
        <20200803205814.540410-9-mst@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Mon, 3 Aug 2020 16:59:09 -0400
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> Since crypto is a modern-only device,
> tag config space fields as having little endian-ness.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  include/uapi/linux/virtio_crypto.h | 26 +++++++++++++-------------
>  1 file changed, 13 insertions(+), 13 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>

