Return-Path: <linux-crypto+bounces-1287-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 059FB827914
	for <lists+linux-crypto@lfdr.de>; Mon,  8 Jan 2024 21:18:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89160B22FD7
	for <lists+linux-crypto@lfdr.de>; Mon,  8 Jan 2024 20:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94BD255C2B;
	Mon,  8 Jan 2024 20:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TlUOmPE5"
X-Original-To: linux-crypto@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB95955C04
	for <linux-crypto@vger.kernel.org>; Mon,  8 Jan 2024 20:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704745038; x=1736281038;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=tyNbLF4NMRTU1x9UrvpK8DEiLClucYu5ZNQR7i87Ho0=;
  b=TlUOmPE53KxS/MuvcycP4vJ7HT3cC6UuySeze8G5TbPlYh9qZ/i31QE0
   +kk8RR46x0nGaQPdJsu3AhTVZiIo7IGUGqOIKPObWM3zps/7uT3BJqnjw
   cnOTrz4II4vNvfw9uLyDmiwmcGJBTLFPySYosTWFg0nGWmIfteVNjpFHt
   PP4m+xuTXSXGMpdfBUE0ccmR3k4PtwZGLgOjJTzxoeb9Zhmrk7deRFGMH
   tvlBaW+/l33kOhGfLXxdj7UwwQX7Ov6+nJ/cN965Qi7wyvPBwIQF4gPv/
   b3JDEm/Wq4aFdZxZTrA1irVYe8kV/466YAhUzgtx42B84NdrHBjY4mrpN
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="5360971"
X-IronPort-AV: E=Sophos;i="6.04,180,1695711600"; 
   d="scan'208";a="5360971"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2024 12:17:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="784967070"
X-IronPort-AV: E=Sophos;i="6.04,180,1695711600"; 
   d="scan'208";a="784967070"
Received: from icubberl-mobl.amr.corp.intel.com ([10.213.165.94])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2024 12:17:17 -0800
Message-ID: <b2e0bd974981291e16882686a2b9b1db3986abe4.camel@linux.intel.com>
Subject: Re: [bug report] crypto: iaa - Add compression mode management
 along with fixed mode
From: Tom Zanussi <tom.zanussi@linux.intel.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: linux-crypto@vger.kernel.org
Date: Mon, 08 Jan 2024 14:17:16 -0600
In-Reply-To: <05696b53-c6ff-45e5-a3f1-d8f407a60050@moroto.mountain>
References: <05696b53-c6ff-45e5-a3f1-d8f407a60050@moroto.mountain>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

SGkgRGFuLAoKT24gTW9uLCAyMDI0LTAxLTA4IGF0IDEyOjI2ICswMzAwLCBEYW4gQ2FycGVudGVy
IHdyb3RlOgo+IEhlbGxvIFRvbSBaYW51c3NpLAo+IAo+IFRoZSBwYXRjaCBiMTkwNDQ3ZTBmYTM6
ICJjcnlwdG86IGlhYSAtIEFkZCBjb21wcmVzc2lvbiBtb2RlCj4gbWFuYWdlbWVudCBhbG9uZyB3
aXRoIGZpeGVkIG1vZGUiIGZyb20gRGVjIDUsIDIwMjMgKGxpbnV4LW5leHQpLAo+IGxlYWRzIHRv
IHRoZSBmb2xsb3dpbmcgU21hdGNoIHN0YXRpYyBjaGVja2VyIHdhcm5pbmc6Cj4gCj4gwqDCoMKg
wqDCoMKgwqDCoGRyaXZlcnMvY3J5cHRvL2ludGVsL2lhYS9pYWFfY3J5cHRvX21haW4uYzo1MzIK
PiBpbml0X2RldmljZV9jb21wcmVzc2lvbl9tb2RlKCkKPiDCoMKgwqDCoMKgwqDCoMKgZXJyb3I6
IG5vdCBhbGxvY2F0aW5nIGVub3VnaCBmb3IgPSAnZGV2aWNlX21vZGUtCj4gPmFlY3NfZGVjb21w
X3RhYmxlJyA1MzUyIHZzIDE2MDAKPiAKPiBkcml2ZXJzL2NyeXB0by9pbnRlbC9pYWEvaWFhX2Ny
eXB0b19tYWluLmMKPiDCoMKgwqAgNTEwIHN0YXRpYyBpbnQgaW5pdF9kZXZpY2VfY29tcHJlc3Np
b25fbW9kZShzdHJ1Y3QgaWFhX2RldmljZQo+ICppYWFfZGV2aWNlLAo+IMKgwqDCoCA1MTHCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3QKPiBpYWFfY29tcHJlc3Npb25fbW9kZSAqbW9kZSwK
PiDCoMKgwqAgNTEywqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaW50IGlkeCwgc3RydWN0Cj4gaWR4
ZF93cSAqd3EpCj4gwqDCoMKgIDUxMyB7Cj4gwqDCoMKgIDUxNMKgwqDCoMKgwqDCoMKgwqAgc2l6
ZV90IHNpemUgPSBzaXplb2Yoc3RydWN0IGFlY3NfY29tcF90YWJsZV9yZWNvcmQpICsKPiBJQUFf
QUVDU19BTElHTjsKPiDCoMKgwqAgNTE1wqDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3QgZGV2aWNlICpk
ZXYgPSAmaWFhX2RldmljZS0+aWR4ZC0+cGRldi0+ZGV2Owo+IMKgwqDCoCA1MTbCoMKgwqDCoMKg
wqDCoMKgIHN0cnVjdCBpYWFfZGV2aWNlX2NvbXByZXNzaW9uX21vZGUgKmRldmljZV9tb2RlOwo+
IMKgwqDCoCA1MTfCoMKgwqDCoMKgwqDCoMKgIGludCByZXQgPSAtRU5PTUVNOwo+IMKgwqDCoCA1
MTggCj4gwqDCoMKgIDUxOcKgwqDCoMKgwqDCoMKgwqAgZGV2aWNlX21vZGUgPSBremFsbG9jKHNp
emVvZigqZGV2aWNlX21vZGUpLAo+IEdGUF9LRVJORUwpOwo+IMKgwqDCoCA1MjDCoMKgwqDCoMKg
wqDCoMKgIGlmICghZGV2aWNlX21vZGUpCj4gwqDCoMKgIDUyMcKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIHJldHVybiAtRU5PTUVNOwo+IMKgwqDCoCA1MjIgCj4gwqDCoMKgIDUyM8Kg
wqDCoMKgwqDCoMKgwqAgZGV2aWNlX21vZGUtPm5hbWUgPSBrc3RyZHVwKG1vZGUtPm5hbWUsIEdG
UF9LRVJORUwpOwo+IMKgwqDCoCA1MjTCoMKgwqDCoMKgwqDCoMKgIGlmICghZGV2aWNlX21vZGUt
Pm5hbWUpCj4gwqDCoMKgIDUyNcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGdvdG8g
ZnJlZTsKPiDCoMKgwqAgNTI2IAo+IMKgwqDCoCA1MjfCoMKgwqDCoMKgwqDCoMKgIGRldmljZV9t
b2RlLT5hZWNzX2NvbXBfdGFibGUgPQo+IGRtYV9hbGxvY19jb2hlcmVudChkZXYsIHNpemUsCj4g
wqDCoMKgIDUyOMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgCj4gJmRldmljZV9tb2RlLT5hZWNzX2NvbXBfdGFibGVfZG1hX2FkZHIsIEdG
UF9LRVJORUwpOwo+IMKgwqDCoCA1MjnCoMKgwqDCoMKgwqDCoMKgIGlmICghZGV2aWNlX21vZGUt
PmFlY3NfY29tcF90YWJsZSkKPiDCoMKgwqAgNTMwwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgZ290byBmcmVlOwo+IMKgwqDCoCA1MzEgCj4gLS0+IDUzMsKgwqDCoMKgwqDCoMKgwqAg
ZGV2aWNlX21vZGUtPmFlY3NfZGVjb21wX3RhYmxlID0KPiBkbWFfYWxsb2NfY29oZXJlbnQoZGV2
LCBzaXplLAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBeXl5eXl4KPiBjb21wIGFuZCBkZWNvbXAgc2l6ZXMgYXJlIGRp
ZmZlcmVudC7CoCBTbyB3ZSBzaG91bGQgYmUgYWxsb2NhdGluZwo+IGFlY3NfZGVjb21wX3RhYmxl
X3JlY29yZCArIElBQV9BRUNTX0FMSUdOIGhlcmUgcHJvYmFibHkuCgpUaGFua3MgZm9yIHBvaW50
aW5nIHRoaXMgb3V0LgoKVGhpcyBpcyBhY3R1YWxseSB1bnVzZWQgYnkgdGhlIGN1cnJlbnQgY29k
ZSAtIGl0IHdhcyBwYXJ0IG9mIHRoZSBjYW5uZWQKbW9kZSB0aGF0IHdhcyByZW1vdmVkIGR1cmlu
ZyByZXZpZXcuCgpJJ2xsIHN1Ym1pdCBhIHBhdGNoIHRvIHJlbW92ZSBpdCBjb21wbGV0ZWx5LCBh
bmQgd2lsbCBmaXggaXQgaWYvd2hlbiB3ZQpyZXN1Ym1pdCBjYW5uZWQgbW9kZS4KClRoYW5rcywK
ClRvbQoKPiAKPiDCoMKgwqAgNTMzwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgCj4gJmRldmljZV9tb2RlLT5hZWNzX2RlY29tcF90
YWJsZV9kbWFfYWRkciwgR0ZQX0tFUk5FTCk7Cj4gwqDCoMKgIDUzNMKgwqDCoMKgwqDCoMKgwqAg
aWYgKCFkZXZpY2VfbW9kZS0+YWVjc19kZWNvbXBfdGFibGUpCj4gwqDCoMKgIDUzNcKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGdvdG8gZnJlZTsKPiDCoMKgwqAgNTM2IAo+IMKgwqDC
oCA1MzfCoMKgwqDCoMKgwqDCoMKgIC8qIEFkZCBIdWZmbWFuIHRhYmxlIHRvIGFlY3MgKi8KPiDC
oMKgwqAgNTM4wqDCoMKgwqDCoMKgwqDCoCBtZW1zZXQoZGV2aWNlX21vZGUtPmFlY3NfY29tcF90
YWJsZSwgMCwKPiBzaXplb2YoKmRldmljZV9tb2RlLT5hZWNzX2NvbXBfdGFibGUpKTsKPiDCoMKg
wqAgNTM5wqDCoMKgwqDCoMKgwqDCoCBtZW1jcHkoZGV2aWNlX21vZGUtPmFlY3NfY29tcF90YWJs
ZS0+bGxfc3ltLCBtb2RlLQo+ID5sbF90YWJsZSwgbW9kZS0+bGxfdGFibGVfc2l6ZSk7Cj4gwqDC
oMKgIDU0MMKgwqDCoMKgwqDCoMKgwqAgbWVtY3B5KGRldmljZV9tb2RlLT5hZWNzX2NvbXBfdGFi
bGUtPmRfc3ltLCBtb2RlLQo+ID5kX3RhYmxlLCBtb2RlLT5kX3RhYmxlX3NpemUpOwo+IMKgwqDC
oCA1NDEgCj4gCj4gcmVnYXJkcywKPiBkYW4gY2FycGVudGVyCgo=


