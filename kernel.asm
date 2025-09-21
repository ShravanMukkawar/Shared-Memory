
kernel:     file format elf32-i386


Disassembly of section .text:

80100000 <multiboot_header>:
80100000:	02 b0 ad 1b 00 00    	add    0x1bad(%eax),%dh
80100006:	00 00                	add    %al,(%eax)
80100008:	fe 4f 52             	decb   0x52(%edi)
8010000b:	e4                   	.byte 0xe4

8010000c <entry>:

# Entering xv6 on boot processor, with paging off.
.globl entry
entry:
  # Turn on page size extension for 4Mbyte pages
  movl    %cr4, %eax
8010000c:	0f 20 e0             	mov    %cr4,%eax
  orl     $(CR4_PSE), %eax
8010000f:	83 c8 10             	or     $0x10,%eax
  movl    %eax, %cr4
80100012:	0f 22 e0             	mov    %eax,%cr4
  # Set page directory
  movl    $(V2P_WO(entrypgdir)), %eax
80100015:	b8 00 a0 10 00       	mov    $0x10a000,%eax
  movl    %eax, %cr3
8010001a:	0f 22 d8             	mov    %eax,%cr3
  # Turn on paging.
  movl    %cr0, %eax
8010001d:	0f 20 c0             	mov    %cr0,%eax
  orl     $(CR0_PG|CR0_WP), %eax
80100020:	0d 00 00 01 80       	or     $0x80010000,%eax
  movl    %eax, %cr0
80100025:	0f 22 c0             	mov    %eax,%cr0

  # Set up the stack pointer.
  movl $(stack + KSTACKSIZE), %esp
80100028:	bc 50 e5 33 80       	mov    $0x8033e550,%esp

  # Jump to main(), and switch to executing at
  # high addresses. The indirect call is needed because
  # the assembler produces a PC-relative instruction
  # for a direct jump.
  mov $main, %eax
8010002d:	b8 90 30 10 80       	mov    $0x80103090,%eax
  jmp *%eax
80100032:	ff e0                	jmp    *%eax
80100034:	66 90                	xchg   %ax,%ax
80100036:	66 90                	xchg   %ax,%ax
80100038:	66 90                	xchg   %ax,%ax
8010003a:	66 90                	xchg   %ax,%ax
8010003c:	66 90                	xchg   %ax,%ax
8010003e:	66 90                	xchg   %ax,%ax

80100040 <binit>:
  struct buf head;
} bcache;

void
binit(void)
{
80100040:	55                   	push   %ebp
80100041:	89 e5                	mov    %esp,%ebp
80100043:	53                   	push   %ebx

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
80100044:	bb b4 35 13 80       	mov    $0x801335b4,%ebx
{
80100049:	83 ec 0c             	sub    $0xc,%esp
  initlock(&bcache.lock, "bcache");
8010004c:	68 60 82 10 80       	push   $0x80108260
80100051:	68 80 35 13 80       	push   $0x80133580
80100056:	e8 55 44 00 00       	call   801044b0 <initlock>
  bcache.head.next = &bcache.head;
8010005b:	83 c4 10             	add    $0x10,%esp
8010005e:	b8 7c 7c 13 80       	mov    $0x80137c7c,%eax
  bcache.head.prev = &bcache.head;
80100063:	c7 05 cc 7c 13 80 7c 	movl   $0x80137c7c,0x80137ccc
8010006a:	7c 13 80 
  bcache.head.next = &bcache.head;
8010006d:	c7 05 d0 7c 13 80 7c 	movl   $0x80137c7c,0x80137cd0
80100074:	7c 13 80 
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
80100077:	eb 09                	jmp    80100082 <binit+0x42>
80100079:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100080:	89 d3                	mov    %edx,%ebx
    b->next = bcache.head.next;
80100082:	89 43 54             	mov    %eax,0x54(%ebx)
    b->prev = &bcache.head;
    initsleeplock(&b->lock, "buffer");
80100085:	83 ec 08             	sub    $0x8,%esp
80100088:	8d 43 0c             	lea    0xc(%ebx),%eax
    b->prev = &bcache.head;
8010008b:	c7 43 50 7c 7c 13 80 	movl   $0x80137c7c,0x50(%ebx)
    initsleeplock(&b->lock, "buffer");
80100092:	68 67 82 10 80       	push   $0x80108267
80100097:	50                   	push   %eax
80100098:	e8 e3 42 00 00       	call   80104380 <initsleeplock>
    bcache.head.next->prev = b;
8010009d:	a1 d0 7c 13 80       	mov    0x80137cd0,%eax
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000a2:	8d 93 5c 02 00 00    	lea    0x25c(%ebx),%edx
801000a8:	83 c4 10             	add    $0x10,%esp
    bcache.head.next->prev = b;
801000ab:	89 58 50             	mov    %ebx,0x50(%eax)
    bcache.head.next = b;
801000ae:	89 d8                	mov    %ebx,%eax
801000b0:	89 1d d0 7c 13 80    	mov    %ebx,0x80137cd0
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000b6:	81 fb 20 7a 13 80    	cmp    $0x80137a20,%ebx
801000bc:	75 c2                	jne    80100080 <binit+0x40>
  }
}
801000be:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801000c1:	c9                   	leave
801000c2:	c3                   	ret
801000c3:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801000ca:	00 
801000cb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

801000d0 <bread>:
}

// Return a locked buf with the contents of the indicated block.
struct buf*
bread(uint dev, uint blockno)
{
801000d0:	55                   	push   %ebp
801000d1:	89 e5                	mov    %esp,%ebp
801000d3:	57                   	push   %edi
801000d4:	56                   	push   %esi
801000d5:	53                   	push   %ebx
801000d6:	83 ec 18             	sub    $0x18,%esp
801000d9:	8b 75 08             	mov    0x8(%ebp),%esi
801000dc:	8b 7d 0c             	mov    0xc(%ebp),%edi
  acquire(&bcache.lock);
801000df:	68 80 35 13 80       	push   $0x80133580
801000e4:	e8 b7 45 00 00       	call   801046a0 <acquire>
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
801000e9:	8b 1d d0 7c 13 80    	mov    0x80137cd0,%ebx
801000ef:	83 c4 10             	add    $0x10,%esp
801000f2:	81 fb 7c 7c 13 80    	cmp    $0x80137c7c,%ebx
801000f8:	75 11                	jne    8010010b <bread+0x3b>
801000fa:	eb 24                	jmp    80100120 <bread+0x50>
801000fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100100:	8b 5b 54             	mov    0x54(%ebx),%ebx
80100103:	81 fb 7c 7c 13 80    	cmp    $0x80137c7c,%ebx
80100109:	74 15                	je     80100120 <bread+0x50>
    if(b->dev == dev && b->blockno == blockno){
8010010b:	3b 73 04             	cmp    0x4(%ebx),%esi
8010010e:	75 f0                	jne    80100100 <bread+0x30>
80100110:	3b 7b 08             	cmp    0x8(%ebx),%edi
80100113:	75 eb                	jne    80100100 <bread+0x30>
      b->refcnt++;
80100115:	83 43 4c 01          	addl   $0x1,0x4c(%ebx)
      release(&bcache.lock);
80100119:	eb 3f                	jmp    8010015a <bread+0x8a>
8010011b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
80100120:	8b 1d cc 7c 13 80    	mov    0x80137ccc,%ebx
80100126:	81 fb 7c 7c 13 80    	cmp    $0x80137c7c,%ebx
8010012c:	75 0d                	jne    8010013b <bread+0x6b>
8010012e:	eb 6e                	jmp    8010019e <bread+0xce>
80100130:	8b 5b 50             	mov    0x50(%ebx),%ebx
80100133:	81 fb 7c 7c 13 80    	cmp    $0x80137c7c,%ebx
80100139:	74 63                	je     8010019e <bread+0xce>
    if(b->refcnt == 0 && (b->flags & B_DIRTY) == 0) {
8010013b:	8b 43 4c             	mov    0x4c(%ebx),%eax
8010013e:	85 c0                	test   %eax,%eax
80100140:	75 ee                	jne    80100130 <bread+0x60>
80100142:	f6 03 04             	testb  $0x4,(%ebx)
80100145:	75 e9                	jne    80100130 <bread+0x60>
      b->dev = dev;
80100147:	89 73 04             	mov    %esi,0x4(%ebx)
      b->blockno = blockno;
8010014a:	89 7b 08             	mov    %edi,0x8(%ebx)
      b->flags = 0;
8010014d:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
      b->refcnt = 1;
80100153:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
      release(&bcache.lock);
8010015a:	83 ec 0c             	sub    $0xc,%esp
8010015d:	68 80 35 13 80       	push   $0x80133580
80100162:	e8 d9 44 00 00       	call   80104640 <release>
      acquiresleep(&b->lock);
80100167:	8d 43 0c             	lea    0xc(%ebx),%eax
8010016a:	89 04 24             	mov    %eax,(%esp)
8010016d:	e8 4e 42 00 00       	call   801043c0 <acquiresleep>
      return b;
80100172:	83 c4 10             	add    $0x10,%esp
  struct buf *b;

  b = bget(dev, blockno);
  if((b->flags & B_VALID) == 0) {
80100175:	f6 03 02             	testb  $0x2,(%ebx)
80100178:	74 0e                	je     80100188 <bread+0xb8>
    iderw(b);
  }
  return b;
}
8010017a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010017d:	89 d8                	mov    %ebx,%eax
8010017f:	5b                   	pop    %ebx
80100180:	5e                   	pop    %esi
80100181:	5f                   	pop    %edi
80100182:	5d                   	pop    %ebp
80100183:	c3                   	ret
80100184:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    iderw(b);
80100188:	83 ec 0c             	sub    $0xc,%esp
8010018b:	53                   	push   %ebx
8010018c:	e8 9f 21 00 00       	call   80102330 <iderw>
80100191:	83 c4 10             	add    $0x10,%esp
}
80100194:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100197:	89 d8                	mov    %ebx,%eax
80100199:	5b                   	pop    %ebx
8010019a:	5e                   	pop    %esi
8010019b:	5f                   	pop    %edi
8010019c:	5d                   	pop    %ebp
8010019d:	c3                   	ret
  panic("bget: no buffers");
8010019e:	83 ec 0c             	sub    $0xc,%esp
801001a1:	68 6e 82 10 80       	push   $0x8010826e
801001a6:	e8 d5 01 00 00       	call   80100380 <panic>
801001ab:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

801001b0 <bwrite>:

// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
801001b0:	55                   	push   %ebp
801001b1:	89 e5                	mov    %esp,%ebp
801001b3:	53                   	push   %ebx
801001b4:	83 ec 10             	sub    $0x10,%esp
801001b7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
801001ba:	8d 43 0c             	lea    0xc(%ebx),%eax
801001bd:	50                   	push   %eax
801001be:	e8 9d 42 00 00       	call   80104460 <holdingsleep>
801001c3:	83 c4 10             	add    $0x10,%esp
801001c6:	85 c0                	test   %eax,%eax
801001c8:	74 0f                	je     801001d9 <bwrite+0x29>
    panic("bwrite");
  b->flags |= B_DIRTY;
801001ca:	83 0b 04             	orl    $0x4,(%ebx)
  iderw(b);
801001cd:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
801001d0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801001d3:	c9                   	leave
  iderw(b);
801001d4:	e9 57 21 00 00       	jmp    80102330 <iderw>
    panic("bwrite");
801001d9:	83 ec 0c             	sub    $0xc,%esp
801001dc:	68 7f 82 10 80       	push   $0x8010827f
801001e1:	e8 9a 01 00 00       	call   80100380 <panic>
801001e6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801001ed:	00 
801001ee:	66 90                	xchg   %ax,%ax

801001f0 <brelse>:

// Release a locked buffer.
// Move to the head of the MRU list.
void
brelse(struct buf *b)
{
801001f0:	55                   	push   %ebp
801001f1:	89 e5                	mov    %esp,%ebp
801001f3:	56                   	push   %esi
801001f4:	53                   	push   %ebx
801001f5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
801001f8:	8d 73 0c             	lea    0xc(%ebx),%esi
801001fb:	83 ec 0c             	sub    $0xc,%esp
801001fe:	56                   	push   %esi
801001ff:	e8 5c 42 00 00       	call   80104460 <holdingsleep>
80100204:	83 c4 10             	add    $0x10,%esp
80100207:	85 c0                	test   %eax,%eax
80100209:	74 63                	je     8010026e <brelse+0x7e>
    panic("brelse");

  releasesleep(&b->lock);
8010020b:	83 ec 0c             	sub    $0xc,%esp
8010020e:	56                   	push   %esi
8010020f:	e8 0c 42 00 00       	call   80104420 <releasesleep>

  acquire(&bcache.lock);
80100214:	c7 04 24 80 35 13 80 	movl   $0x80133580,(%esp)
8010021b:	e8 80 44 00 00       	call   801046a0 <acquire>
  b->refcnt--;
80100220:	8b 43 4c             	mov    0x4c(%ebx),%eax
  if (b->refcnt == 0) {
80100223:	83 c4 10             	add    $0x10,%esp
  b->refcnt--;
80100226:	83 e8 01             	sub    $0x1,%eax
80100229:	89 43 4c             	mov    %eax,0x4c(%ebx)
  if (b->refcnt == 0) {
8010022c:	85 c0                	test   %eax,%eax
8010022e:	75 2c                	jne    8010025c <brelse+0x6c>
    // no one is waiting for it.
    b->next->prev = b->prev;
80100230:	8b 53 54             	mov    0x54(%ebx),%edx
80100233:	8b 43 50             	mov    0x50(%ebx),%eax
80100236:	89 42 50             	mov    %eax,0x50(%edx)
    b->prev->next = b->next;
80100239:	8b 53 54             	mov    0x54(%ebx),%edx
8010023c:	89 50 54             	mov    %edx,0x54(%eax)
    b->next = bcache.head.next;
8010023f:	a1 d0 7c 13 80       	mov    0x80137cd0,%eax
    b->prev = &bcache.head;
80100244:	c7 43 50 7c 7c 13 80 	movl   $0x80137c7c,0x50(%ebx)
    b->next = bcache.head.next;
8010024b:	89 43 54             	mov    %eax,0x54(%ebx)
    bcache.head.next->prev = b;
8010024e:	a1 d0 7c 13 80       	mov    0x80137cd0,%eax
80100253:	89 58 50             	mov    %ebx,0x50(%eax)
    bcache.head.next = b;
80100256:	89 1d d0 7c 13 80    	mov    %ebx,0x80137cd0
  }
  
  release(&bcache.lock);
8010025c:	c7 45 08 80 35 13 80 	movl   $0x80133580,0x8(%ebp)
}
80100263:	8d 65 f8             	lea    -0x8(%ebp),%esp
80100266:	5b                   	pop    %ebx
80100267:	5e                   	pop    %esi
80100268:	5d                   	pop    %ebp
  release(&bcache.lock);
80100269:	e9 d2 43 00 00       	jmp    80104640 <release>
    panic("brelse");
8010026e:	83 ec 0c             	sub    $0xc,%esp
80100271:	68 86 82 10 80       	push   $0x80108286
80100276:	e8 05 01 00 00       	call   80100380 <panic>
8010027b:	66 90                	xchg   %ax,%ax
8010027d:	66 90                	xchg   %ax,%ax
8010027f:	90                   	nop

80100280 <consoleread>:
  }
}

int
consoleread(struct inode *ip, char *dst, int n)
{
80100280:	55                   	push   %ebp
80100281:	89 e5                	mov    %esp,%ebp
80100283:	57                   	push   %edi
80100284:	56                   	push   %esi
80100285:	53                   	push   %ebx
80100286:	83 ec 18             	sub    $0x18,%esp
80100289:	8b 5d 10             	mov    0x10(%ebp),%ebx
8010028c:	8b 75 0c             	mov    0xc(%ebp),%esi
  uint target;
  int c;

  iunlock(ip);
8010028f:	ff 75 08             	push   0x8(%ebp)
  target = n;
80100292:	89 df                	mov    %ebx,%edi
  iunlock(ip);
80100294:	e8 47 16 00 00       	call   801018e0 <iunlock>
  acquire(&cons.lock);
80100299:	c7 04 24 80 7f 13 80 	movl   $0x80137f80,(%esp)
801002a0:	e8 fb 43 00 00       	call   801046a0 <acquire>
  while(n > 0){
801002a5:	83 c4 10             	add    $0x10,%esp
801002a8:	85 db                	test   %ebx,%ebx
801002aa:	0f 8e 94 00 00 00    	jle    80100344 <consoleread+0xc4>
    while(input.r == input.w){
801002b0:	a1 60 7f 13 80       	mov    0x80137f60,%eax
801002b5:	39 05 64 7f 13 80    	cmp    %eax,0x80137f64
801002bb:	74 25                	je     801002e2 <consoleread+0x62>
801002bd:	eb 59                	jmp    80100318 <consoleread+0x98>
801002bf:	90                   	nop
      if(myproc()->killed){
        release(&cons.lock);
        ilock(ip);
        return -1;
      }
      sleep(&input.r, &cons.lock);
801002c0:	83 ec 08             	sub    $0x8,%esp
801002c3:	68 80 7f 13 80       	push   $0x80137f80
801002c8:	68 60 7f 13 80       	push   $0x80137f60
801002cd:	e8 4e 3e 00 00       	call   80104120 <sleep>
    while(input.r == input.w){
801002d2:	a1 60 7f 13 80       	mov    0x80137f60,%eax
801002d7:	83 c4 10             	add    $0x10,%esp
801002da:	3b 05 64 7f 13 80    	cmp    0x80137f64,%eax
801002e0:	75 36                	jne    80100318 <consoleread+0x98>
      if(myproc()->killed){
801002e2:	e8 e9 36 00 00       	call   801039d0 <myproc>
801002e7:	8b 48 24             	mov    0x24(%eax),%ecx
801002ea:	85 c9                	test   %ecx,%ecx
801002ec:	74 d2                	je     801002c0 <consoleread+0x40>
        release(&cons.lock);
801002ee:	83 ec 0c             	sub    $0xc,%esp
801002f1:	68 80 7f 13 80       	push   $0x80137f80
801002f6:	e8 45 43 00 00       	call   80104640 <release>
        ilock(ip);
801002fb:	5a                   	pop    %edx
801002fc:	ff 75 08             	push   0x8(%ebp)
801002ff:	e8 fc 14 00 00       	call   80101800 <ilock>
        return -1;
80100304:	83 c4 10             	add    $0x10,%esp
  }
  release(&cons.lock);
  ilock(ip);

  return target - n;
}
80100307:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return -1;
8010030a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010030f:	5b                   	pop    %ebx
80100310:	5e                   	pop    %esi
80100311:	5f                   	pop    %edi
80100312:	5d                   	pop    %ebp
80100313:	c3                   	ret
80100314:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c = input.buf[input.r++ % INPUT_BUF];
80100318:	8d 50 01             	lea    0x1(%eax),%edx
8010031b:	89 15 60 7f 13 80    	mov    %edx,0x80137f60
80100321:	89 c2                	mov    %eax,%edx
80100323:	83 e2 7f             	and    $0x7f,%edx
80100326:	0f be 8a e0 7e 13 80 	movsbl -0x7fec8120(%edx),%ecx
    if(c == C('D')){  // EOF
8010032d:	80 f9 04             	cmp    $0x4,%cl
80100330:	74 37                	je     80100369 <consoleread+0xe9>
    *dst++ = c;
80100332:	83 c6 01             	add    $0x1,%esi
    --n;
80100335:	83 eb 01             	sub    $0x1,%ebx
    *dst++ = c;
80100338:	88 4e ff             	mov    %cl,-0x1(%esi)
    if(c == '\n')
8010033b:	83 f9 0a             	cmp    $0xa,%ecx
8010033e:	0f 85 64 ff ff ff    	jne    801002a8 <consoleread+0x28>
  release(&cons.lock);
80100344:	83 ec 0c             	sub    $0xc,%esp
80100347:	68 80 7f 13 80       	push   $0x80137f80
8010034c:	e8 ef 42 00 00       	call   80104640 <release>
  ilock(ip);
80100351:	58                   	pop    %eax
80100352:	ff 75 08             	push   0x8(%ebp)
80100355:	e8 a6 14 00 00       	call   80101800 <ilock>
  return target - n;
8010035a:	89 f8                	mov    %edi,%eax
8010035c:	83 c4 10             	add    $0x10,%esp
}
8010035f:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return target - n;
80100362:	29 d8                	sub    %ebx,%eax
}
80100364:	5b                   	pop    %ebx
80100365:	5e                   	pop    %esi
80100366:	5f                   	pop    %edi
80100367:	5d                   	pop    %ebp
80100368:	c3                   	ret
      if(n < target){
80100369:	39 fb                	cmp    %edi,%ebx
8010036b:	73 d7                	jae    80100344 <consoleread+0xc4>
        input.r--;
8010036d:	a3 60 7f 13 80       	mov    %eax,0x80137f60
80100372:	eb d0                	jmp    80100344 <consoleread+0xc4>
80100374:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010037b:	00 
8010037c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100380 <panic>:
{
80100380:	55                   	push   %ebp
80100381:	89 e5                	mov    %esp,%ebp
80100383:	56                   	push   %esi
80100384:	53                   	push   %ebx
80100385:	83 ec 30             	sub    $0x30,%esp
}

static inline void
cli(void)
{
  asm volatile("cli");
80100388:	fa                   	cli
  cons.locking = 0;
80100389:	c7 05 b4 7f 13 80 00 	movl   $0x0,0x80137fb4
80100390:	00 00 00 
  getcallerpcs(&s, pcs);
80100393:	8d 5d d0             	lea    -0x30(%ebp),%ebx
80100396:	8d 75 f8             	lea    -0x8(%ebp),%esi
  cprintf("lapicid %d: panic: ", lapicid());
80100399:	e8 92 25 00 00       	call   80102930 <lapicid>
8010039e:	83 ec 08             	sub    $0x8,%esp
801003a1:	50                   	push   %eax
801003a2:	68 8d 82 10 80       	push   $0x8010828d
801003a7:	e8 04 03 00 00       	call   801006b0 <cprintf>
  cprintf(s);
801003ac:	58                   	pop    %eax
801003ad:	ff 75 08             	push   0x8(%ebp)
801003b0:	e8 fb 02 00 00       	call   801006b0 <cprintf>
  cprintf("\n");
801003b5:	c7 04 24 5f 88 10 80 	movl   $0x8010885f,(%esp)
801003bc:	e8 ef 02 00 00       	call   801006b0 <cprintf>
  getcallerpcs(&s, pcs);
801003c1:	8d 45 08             	lea    0x8(%ebp),%eax
801003c4:	5a                   	pop    %edx
801003c5:	59                   	pop    %ecx
801003c6:	53                   	push   %ebx
801003c7:	50                   	push   %eax
801003c8:	e8 03 41 00 00       	call   801044d0 <getcallerpcs>
  for(i=0; i<10; i++)
801003cd:	83 c4 10             	add    $0x10,%esp
    cprintf(" %p", pcs[i]);
801003d0:	83 ec 08             	sub    $0x8,%esp
801003d3:	ff 33                	push   (%ebx)
  for(i=0; i<10; i++)
801003d5:	83 c3 04             	add    $0x4,%ebx
    cprintf(" %p", pcs[i]);
801003d8:	68 a1 82 10 80       	push   $0x801082a1
801003dd:	e8 ce 02 00 00       	call   801006b0 <cprintf>
  for(i=0; i<10; i++)
801003e2:	83 c4 10             	add    $0x10,%esp
801003e5:	39 f3                	cmp    %esi,%ebx
801003e7:	75 e7                	jne    801003d0 <panic+0x50>
  panicked = 1; // freeze other CPU
801003e9:	c7 05 b8 7f 13 80 01 	movl   $0x1,0x80137fb8
801003f0:	00 00 00 
  for(;;)
801003f3:	eb fe                	jmp    801003f3 <panic+0x73>
801003f5:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801003fc:	00 
801003fd:	8d 76 00             	lea    0x0(%esi),%esi

80100400 <consputc.part.0>:
consputc(int c)
80100400:	55                   	push   %ebp
80100401:	89 e5                	mov    %esp,%ebp
80100403:	57                   	push   %edi
80100404:	56                   	push   %esi
80100405:	53                   	push   %ebx
80100406:	83 ec 1c             	sub    $0x1c,%esp
  if(c == BACKSPACE){
80100409:	3d 00 01 00 00       	cmp    $0x100,%eax
8010040e:	0f 84 cc 00 00 00    	je     801004e0 <consputc.part.0+0xe0>
    uartputc(c);
80100414:	83 ec 0c             	sub    $0xc,%esp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100417:	bf d4 03 00 00       	mov    $0x3d4,%edi
8010041c:	89 c3                	mov    %eax,%ebx
8010041e:	50                   	push   %eax
8010041f:	e8 7c 5b 00 00       	call   80105fa0 <uartputc>
80100424:	b8 0e 00 00 00       	mov    $0xe,%eax
80100429:	89 fa                	mov    %edi,%edx
8010042b:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010042c:	be d5 03 00 00       	mov    $0x3d5,%esi
80100431:	89 f2                	mov    %esi,%edx
80100433:	ec                   	in     (%dx),%al
  pos = inb(CRTPORT+1) << 8;
80100434:	0f b6 c8             	movzbl %al,%ecx
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100437:	89 fa                	mov    %edi,%edx
80100439:	b8 0f 00 00 00       	mov    $0xf,%eax
8010043e:	c1 e1 08             	shl    $0x8,%ecx
80100441:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100442:	89 f2                	mov    %esi,%edx
80100444:	ec                   	in     (%dx),%al
  pos |= inb(CRTPORT+1);
80100445:	0f b6 c0             	movzbl %al,%eax
  if(c == '\n')
80100448:	83 c4 10             	add    $0x10,%esp
  pos |= inb(CRTPORT+1);
8010044b:	09 c8                	or     %ecx,%eax
  if(c == '\n')
8010044d:	83 fb 0a             	cmp    $0xa,%ebx
80100450:	75 76                	jne    801004c8 <consputc.part.0+0xc8>
    pos += 80 - pos%80;
80100452:	ba cd cc cc cc       	mov    $0xcccccccd,%edx
80100457:	f7 e2                	mul    %edx
80100459:	c1 ea 06             	shr    $0x6,%edx
8010045c:	8d 04 92             	lea    (%edx,%edx,4),%eax
8010045f:	c1 e0 04             	shl    $0x4,%eax
80100462:	8d 70 50             	lea    0x50(%eax),%esi
  if(pos < 0 || pos > 25*80)
80100465:	81 fe d0 07 00 00    	cmp    $0x7d0,%esi
8010046b:	0f 8f 2f 01 00 00    	jg     801005a0 <consputc.part.0+0x1a0>
  if((pos/80) >= 24){  // Scroll up.
80100471:	81 fe 7f 07 00 00    	cmp    $0x77f,%esi
80100477:	0f 8f c3 00 00 00    	jg     80100540 <consputc.part.0+0x140>
  outb(CRTPORT+1, pos>>8);
8010047d:	89 f0                	mov    %esi,%eax
  crt[pos] = ' ' | 0x0700;
8010047f:	8d b4 36 00 80 0b 80 	lea    -0x7ff48000(%esi,%esi,1),%esi
  outb(CRTPORT+1, pos);
80100486:	88 45 e7             	mov    %al,-0x19(%ebp)
  outb(CRTPORT+1, pos>>8);
80100489:	0f b6 fc             	movzbl %ah,%edi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010048c:	bb d4 03 00 00       	mov    $0x3d4,%ebx
80100491:	b8 0e 00 00 00       	mov    $0xe,%eax
80100496:	89 da                	mov    %ebx,%edx
80100498:	ee                   	out    %al,(%dx)
80100499:	b9 d5 03 00 00       	mov    $0x3d5,%ecx
8010049e:	89 f8                	mov    %edi,%eax
801004a0:	89 ca                	mov    %ecx,%edx
801004a2:	ee                   	out    %al,(%dx)
801004a3:	b8 0f 00 00 00       	mov    $0xf,%eax
801004a8:	89 da                	mov    %ebx,%edx
801004aa:	ee                   	out    %al,(%dx)
801004ab:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
801004af:	89 ca                	mov    %ecx,%edx
801004b1:	ee                   	out    %al,(%dx)
  crt[pos] = ' ' | 0x0700;
801004b2:	b8 20 07 00 00       	mov    $0x720,%eax
801004b7:	66 89 06             	mov    %ax,(%esi)
}
801004ba:	8d 65 f4             	lea    -0xc(%ebp),%esp
801004bd:	5b                   	pop    %ebx
801004be:	5e                   	pop    %esi
801004bf:	5f                   	pop    %edi
801004c0:	5d                   	pop    %ebp
801004c1:	c3                   	ret
801004c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    crt[pos++] = (c&0xff) | 0x0700;  // black on white
801004c8:	0f b6 db             	movzbl %bl,%ebx
801004cb:	8d 70 01             	lea    0x1(%eax),%esi
801004ce:	80 cf 07             	or     $0x7,%bh
801004d1:	66 89 9c 00 00 80 0b 	mov    %bx,-0x7ff48000(%eax,%eax,1)
801004d8:	80 
801004d9:	eb 8a                	jmp    80100465 <consputc.part.0+0x65>
801004db:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    uartputc('\b'); uartputc(' '); uartputc('\b');
801004e0:	83 ec 0c             	sub    $0xc,%esp
801004e3:	be d4 03 00 00       	mov    $0x3d4,%esi
801004e8:	6a 08                	push   $0x8
801004ea:	e8 b1 5a 00 00       	call   80105fa0 <uartputc>
801004ef:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
801004f6:	e8 a5 5a 00 00       	call   80105fa0 <uartputc>
801004fb:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
80100502:	e8 99 5a 00 00       	call   80105fa0 <uartputc>
80100507:	b8 0e 00 00 00       	mov    $0xe,%eax
8010050c:	89 f2                	mov    %esi,%edx
8010050e:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010050f:	bb d5 03 00 00       	mov    $0x3d5,%ebx
80100514:	89 da                	mov    %ebx,%edx
80100516:	ec                   	in     (%dx),%al
  pos = inb(CRTPORT+1) << 8;
80100517:	0f b6 c8             	movzbl %al,%ecx
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010051a:	89 f2                	mov    %esi,%edx
8010051c:	b8 0f 00 00 00       	mov    $0xf,%eax
80100521:	c1 e1 08             	shl    $0x8,%ecx
80100524:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100525:	89 da                	mov    %ebx,%edx
80100527:	ec                   	in     (%dx),%al
  pos |= inb(CRTPORT+1);
80100528:	0f b6 f0             	movzbl %al,%esi
    if(pos > 0) --pos;
8010052b:	83 c4 10             	add    $0x10,%esp
8010052e:	09 ce                	or     %ecx,%esi
80100530:	74 5e                	je     80100590 <consputc.part.0+0x190>
80100532:	83 ee 01             	sub    $0x1,%esi
80100535:	e9 2b ff ff ff       	jmp    80100465 <consputc.part.0+0x65>
8010053a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
80100540:	83 ec 04             	sub    $0x4,%esp
    pos -= 80;
80100543:	8d 5e b0             	lea    -0x50(%esi),%ebx
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
80100546:	8d b4 36 60 7f 0b 80 	lea    -0x7ff480a0(%esi,%esi,1),%esi
  outb(CRTPORT+1, pos);
8010054d:	bf 07 00 00 00       	mov    $0x7,%edi
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
80100552:	68 60 0e 00 00       	push   $0xe60
80100557:	68 a0 80 0b 80       	push   $0x800b80a0
8010055c:	68 00 80 0b 80       	push   $0x800b8000
80100561:	e8 ca 42 00 00       	call   80104830 <memmove>
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
80100566:	b8 80 07 00 00       	mov    $0x780,%eax
8010056b:	83 c4 0c             	add    $0xc,%esp
8010056e:	29 d8                	sub    %ebx,%eax
80100570:	01 c0                	add    %eax,%eax
80100572:	50                   	push   %eax
80100573:	6a 00                	push   $0x0
80100575:	56                   	push   %esi
80100576:	e8 25 42 00 00       	call   801047a0 <memset>
  outb(CRTPORT+1, pos);
8010057b:	88 5d e7             	mov    %bl,-0x19(%ebp)
8010057e:	83 c4 10             	add    $0x10,%esp
80100581:	e9 06 ff ff ff       	jmp    8010048c <consputc.part.0+0x8c>
80100586:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010058d:	00 
8010058e:	66 90                	xchg   %ax,%ax
80100590:	c6 45 e7 00          	movb   $0x0,-0x19(%ebp)
80100594:	be 00 80 0b 80       	mov    $0x800b8000,%esi
80100599:	31 ff                	xor    %edi,%edi
8010059b:	e9 ec fe ff ff       	jmp    8010048c <consputc.part.0+0x8c>
    panic("pos under/overflow");
801005a0:	83 ec 0c             	sub    $0xc,%esp
801005a3:	68 a5 82 10 80       	push   $0x801082a5
801005a8:	e8 d3 fd ff ff       	call   80100380 <panic>
801005ad:	8d 76 00             	lea    0x0(%esi),%esi

801005b0 <consolewrite>:

int
consolewrite(struct inode *ip, char *buf, int n)
{
801005b0:	55                   	push   %ebp
801005b1:	89 e5                	mov    %esp,%ebp
801005b3:	57                   	push   %edi
801005b4:	56                   	push   %esi
801005b5:	53                   	push   %ebx
801005b6:	83 ec 18             	sub    $0x18,%esp
801005b9:	8b 75 10             	mov    0x10(%ebp),%esi
  int i;

  iunlock(ip);
801005bc:	ff 75 08             	push   0x8(%ebp)
801005bf:	e8 1c 13 00 00       	call   801018e0 <iunlock>
  acquire(&cons.lock);
801005c4:	c7 04 24 80 7f 13 80 	movl   $0x80137f80,(%esp)
801005cb:	e8 d0 40 00 00       	call   801046a0 <acquire>
  for(i = 0; i < n; i++)
801005d0:	83 c4 10             	add    $0x10,%esp
801005d3:	85 f6                	test   %esi,%esi
801005d5:	7e 25                	jle    801005fc <consolewrite+0x4c>
801005d7:	8b 5d 0c             	mov    0xc(%ebp),%ebx
801005da:	8d 3c 33             	lea    (%ebx,%esi,1),%edi
  if(panicked){
801005dd:	8b 15 b8 7f 13 80    	mov    0x80137fb8,%edx
    consputc(buf[i] & 0xff);
801005e3:	0f b6 03             	movzbl (%ebx),%eax
  if(panicked){
801005e6:	85 d2                	test   %edx,%edx
801005e8:	74 06                	je     801005f0 <consolewrite+0x40>
  asm volatile("cli");
801005ea:	fa                   	cli
    for(;;)
801005eb:	eb fe                	jmp    801005eb <consolewrite+0x3b>
801005ed:	8d 76 00             	lea    0x0(%esi),%esi
801005f0:	e8 0b fe ff ff       	call   80100400 <consputc.part.0>
  for(i = 0; i < n; i++)
801005f5:	83 c3 01             	add    $0x1,%ebx
801005f8:	39 fb                	cmp    %edi,%ebx
801005fa:	75 e1                	jne    801005dd <consolewrite+0x2d>
  release(&cons.lock);
801005fc:	83 ec 0c             	sub    $0xc,%esp
801005ff:	68 80 7f 13 80       	push   $0x80137f80
80100604:	e8 37 40 00 00       	call   80104640 <release>
  ilock(ip);
80100609:	58                   	pop    %eax
8010060a:	ff 75 08             	push   0x8(%ebp)
8010060d:	e8 ee 11 00 00       	call   80101800 <ilock>

  return n;
}
80100612:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100615:	89 f0                	mov    %esi,%eax
80100617:	5b                   	pop    %ebx
80100618:	5e                   	pop    %esi
80100619:	5f                   	pop    %edi
8010061a:	5d                   	pop    %ebp
8010061b:	c3                   	ret
8010061c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100620 <printint>:
{
80100620:	55                   	push   %ebp
80100621:	89 e5                	mov    %esp,%ebp
80100623:	57                   	push   %edi
80100624:	56                   	push   %esi
80100625:	53                   	push   %ebx
80100626:	89 d3                	mov    %edx,%ebx
80100628:	83 ec 2c             	sub    $0x2c,%esp
  if(sign && (sign = xx < 0))
8010062b:	85 c0                	test   %eax,%eax
8010062d:	79 05                	jns    80100634 <printint+0x14>
8010062f:	83 e1 01             	and    $0x1,%ecx
80100632:	75 64                	jne    80100698 <printint+0x78>
    x = xx;
80100634:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
8010063b:	89 c1                	mov    %eax,%ecx
  i = 0;
8010063d:	31 f6                	xor    %esi,%esi
8010063f:	90                   	nop
    buf[i++] = digits[x % base];
80100640:	89 c8                	mov    %ecx,%eax
80100642:	31 d2                	xor    %edx,%edx
80100644:	89 f7                	mov    %esi,%edi
80100646:	f7 f3                	div    %ebx
80100648:	8d 76 01             	lea    0x1(%esi),%esi
8010064b:	0f b6 92 64 88 10 80 	movzbl -0x7fef779c(%edx),%edx
80100652:	88 54 35 d7          	mov    %dl,-0x29(%ebp,%esi,1)
  }while((x /= base) != 0);
80100656:	89 ca                	mov    %ecx,%edx
80100658:	89 c1                	mov    %eax,%ecx
8010065a:	39 da                	cmp    %ebx,%edx
8010065c:	73 e2                	jae    80100640 <printint+0x20>
  if(sign)
8010065e:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
80100661:	85 c9                	test   %ecx,%ecx
80100663:	74 07                	je     8010066c <printint+0x4c>
    buf[i++] = '-';
80100665:	c6 44 35 d8 2d       	movb   $0x2d,-0x28(%ebp,%esi,1)
  while(--i >= 0)
8010066a:	89 f7                	mov    %esi,%edi
8010066c:	8d 5d d8             	lea    -0x28(%ebp),%ebx
8010066f:	01 df                	add    %ebx,%edi
  if(panicked){
80100671:	8b 15 b8 7f 13 80    	mov    0x80137fb8,%edx
    consputc(buf[i]);
80100677:	0f be 07             	movsbl (%edi),%eax
  if(panicked){
8010067a:	85 d2                	test   %edx,%edx
8010067c:	74 0a                	je     80100688 <printint+0x68>
8010067e:	fa                   	cli
    for(;;)
8010067f:	eb fe                	jmp    8010067f <printint+0x5f>
80100681:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100688:	e8 73 fd ff ff       	call   80100400 <consputc.part.0>
  while(--i >= 0)
8010068d:	8d 47 ff             	lea    -0x1(%edi),%eax
80100690:	39 df                	cmp    %ebx,%edi
80100692:	74 11                	je     801006a5 <printint+0x85>
80100694:	89 c7                	mov    %eax,%edi
80100696:	eb d9                	jmp    80100671 <printint+0x51>
    x = -xx;
80100698:	f7 d8                	neg    %eax
  if(sign && (sign = xx < 0))
8010069a:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%ebp)
    x = -xx;
801006a1:	89 c1                	mov    %eax,%ecx
801006a3:	eb 98                	jmp    8010063d <printint+0x1d>
}
801006a5:	83 c4 2c             	add    $0x2c,%esp
801006a8:	5b                   	pop    %ebx
801006a9:	5e                   	pop    %esi
801006aa:	5f                   	pop    %edi
801006ab:	5d                   	pop    %ebp
801006ac:	c3                   	ret
801006ad:	8d 76 00             	lea    0x0(%esi),%esi

801006b0 <cprintf>:
{
801006b0:	55                   	push   %ebp
801006b1:	89 e5                	mov    %esp,%ebp
801006b3:	57                   	push   %edi
801006b4:	56                   	push   %esi
801006b5:	53                   	push   %ebx
801006b6:	83 ec 1c             	sub    $0x1c,%esp
  locking = cons.locking;
801006b9:	8b 3d b4 7f 13 80    	mov    0x80137fb4,%edi
  if (fmt == 0)
801006bf:	8b 75 08             	mov    0x8(%ebp),%esi
  if(locking)
801006c2:	85 ff                	test   %edi,%edi
801006c4:	0f 85 06 01 00 00    	jne    801007d0 <cprintf+0x120>
  if (fmt == 0)
801006ca:	85 f6                	test   %esi,%esi
801006cc:	0f 84 b7 01 00 00    	je     80100889 <cprintf+0x1d9>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801006d2:	0f b6 06             	movzbl (%esi),%eax
801006d5:	85 c0                	test   %eax,%eax
801006d7:	74 5f                	je     80100738 <cprintf+0x88>
  argp = (uint*)(void*)(&fmt + 1);
801006d9:	8d 55 0c             	lea    0xc(%ebp),%edx
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801006dc:	89 7d e4             	mov    %edi,-0x1c(%ebp)
801006df:	31 db                	xor    %ebx,%ebx
801006e1:	89 d7                	mov    %edx,%edi
    if(c != '%'){
801006e3:	83 f8 25             	cmp    $0x25,%eax
801006e6:	75 58                	jne    80100740 <cprintf+0x90>
    c = fmt[++i] & 0xff;
801006e8:	83 c3 01             	add    $0x1,%ebx
801006eb:	0f b6 0c 1e          	movzbl (%esi,%ebx,1),%ecx
    if(c == 0)
801006ef:	85 c9                	test   %ecx,%ecx
801006f1:	74 3a                	je     8010072d <cprintf+0x7d>
    switch(c){
801006f3:	83 f9 70             	cmp    $0x70,%ecx
801006f6:	0f 84 b4 00 00 00    	je     801007b0 <cprintf+0x100>
801006fc:	7f 72                	jg     80100770 <cprintf+0xc0>
801006fe:	83 f9 25             	cmp    $0x25,%ecx
80100701:	74 4d                	je     80100750 <cprintf+0xa0>
80100703:	83 f9 64             	cmp    $0x64,%ecx
80100706:	75 76                	jne    8010077e <cprintf+0xce>
      printint(*argp++, 10, 1);
80100708:	8d 47 04             	lea    0x4(%edi),%eax
8010070b:	b9 01 00 00 00       	mov    $0x1,%ecx
80100710:	ba 0a 00 00 00       	mov    $0xa,%edx
80100715:	89 45 e0             	mov    %eax,-0x20(%ebp)
80100718:	8b 07                	mov    (%edi),%eax
8010071a:	e8 01 ff ff ff       	call   80100620 <printint>
8010071f:	8b 7d e0             	mov    -0x20(%ebp),%edi
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100722:	83 c3 01             	add    $0x1,%ebx
80100725:	0f b6 04 1e          	movzbl (%esi,%ebx,1),%eax
80100729:	85 c0                	test   %eax,%eax
8010072b:	75 b6                	jne    801006e3 <cprintf+0x33>
8010072d:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  if(locking)
80100730:	85 ff                	test   %edi,%edi
80100732:	0f 85 bb 00 00 00    	jne    801007f3 <cprintf+0x143>
}
80100738:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010073b:	5b                   	pop    %ebx
8010073c:	5e                   	pop    %esi
8010073d:	5f                   	pop    %edi
8010073e:	5d                   	pop    %ebp
8010073f:	c3                   	ret
  if(panicked){
80100740:	8b 0d b8 7f 13 80    	mov    0x80137fb8,%ecx
80100746:	85 c9                	test   %ecx,%ecx
80100748:	74 19                	je     80100763 <cprintf+0xb3>
8010074a:	fa                   	cli
    for(;;)
8010074b:	eb fe                	jmp    8010074b <cprintf+0x9b>
8010074d:	8d 76 00             	lea    0x0(%esi),%esi
  if(panicked){
80100750:	8b 0d b8 7f 13 80    	mov    0x80137fb8,%ecx
80100756:	85 c9                	test   %ecx,%ecx
80100758:	0f 85 f2 00 00 00    	jne    80100850 <cprintf+0x1a0>
8010075e:	b8 25 00 00 00       	mov    $0x25,%eax
80100763:	e8 98 fc ff ff       	call   80100400 <consputc.part.0>
      break;
80100768:	eb b8                	jmp    80100722 <cprintf+0x72>
8010076a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    switch(c){
80100770:	83 f9 73             	cmp    $0x73,%ecx
80100773:	0f 84 8f 00 00 00    	je     80100808 <cprintf+0x158>
80100779:	83 f9 78             	cmp    $0x78,%ecx
8010077c:	74 32                	je     801007b0 <cprintf+0x100>
  if(panicked){
8010077e:	8b 15 b8 7f 13 80    	mov    0x80137fb8,%edx
80100784:	85 d2                	test   %edx,%edx
80100786:	0f 85 b8 00 00 00    	jne    80100844 <cprintf+0x194>
8010078c:	b8 25 00 00 00       	mov    $0x25,%eax
80100791:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80100794:	e8 67 fc ff ff       	call   80100400 <consputc.part.0>
80100799:	a1 b8 7f 13 80       	mov    0x80137fb8,%eax
8010079e:	8b 4d e0             	mov    -0x20(%ebp),%ecx
801007a1:	85 c0                	test   %eax,%eax
801007a3:	0f 84 cd 00 00 00    	je     80100876 <cprintf+0x1c6>
801007a9:	fa                   	cli
    for(;;)
801007aa:	eb fe                	jmp    801007aa <cprintf+0xfa>
801007ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      printint(*argp++, 16, 0);
801007b0:	8d 47 04             	lea    0x4(%edi),%eax
801007b3:	31 c9                	xor    %ecx,%ecx
801007b5:	ba 10 00 00 00       	mov    $0x10,%edx
801007ba:	89 45 e0             	mov    %eax,-0x20(%ebp)
801007bd:	8b 07                	mov    (%edi),%eax
801007bf:	e8 5c fe ff ff       	call   80100620 <printint>
801007c4:	8b 7d e0             	mov    -0x20(%ebp),%edi
      break;
801007c7:	e9 56 ff ff ff       	jmp    80100722 <cprintf+0x72>
801007cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    acquire(&cons.lock);
801007d0:	83 ec 0c             	sub    $0xc,%esp
801007d3:	68 80 7f 13 80       	push   $0x80137f80
801007d8:	e8 c3 3e 00 00       	call   801046a0 <acquire>
  if (fmt == 0)
801007dd:	83 c4 10             	add    $0x10,%esp
801007e0:	85 f6                	test   %esi,%esi
801007e2:	0f 84 a1 00 00 00    	je     80100889 <cprintf+0x1d9>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801007e8:	0f b6 06             	movzbl (%esi),%eax
801007eb:	85 c0                	test   %eax,%eax
801007ed:	0f 85 e6 fe ff ff    	jne    801006d9 <cprintf+0x29>
    release(&cons.lock);
801007f3:	83 ec 0c             	sub    $0xc,%esp
801007f6:	68 80 7f 13 80       	push   $0x80137f80
801007fb:	e8 40 3e 00 00       	call   80104640 <release>
80100800:	83 c4 10             	add    $0x10,%esp
80100803:	e9 30 ff ff ff       	jmp    80100738 <cprintf+0x88>
      if((s = (char*)*argp++) == 0)
80100808:	8b 17                	mov    (%edi),%edx
8010080a:	8d 47 04             	lea    0x4(%edi),%eax
8010080d:	85 d2                	test   %edx,%edx
8010080f:	74 27                	je     80100838 <cprintf+0x188>
      for(; *s; s++)
80100811:	0f b6 0a             	movzbl (%edx),%ecx
      if((s = (char*)*argp++) == 0)
80100814:	89 d7                	mov    %edx,%edi
      for(; *s; s++)
80100816:	84 c9                	test   %cl,%cl
80100818:	74 68                	je     80100882 <cprintf+0x1d2>
8010081a:	89 5d e0             	mov    %ebx,-0x20(%ebp)
8010081d:	89 fb                	mov    %edi,%ebx
8010081f:	89 f7                	mov    %esi,%edi
80100821:	89 c6                	mov    %eax,%esi
80100823:	0f be c1             	movsbl %cl,%eax
  if(panicked){
80100826:	8b 15 b8 7f 13 80    	mov    0x80137fb8,%edx
8010082c:	85 d2                	test   %edx,%edx
8010082e:	74 28                	je     80100858 <cprintf+0x1a8>
80100830:	fa                   	cli
    for(;;)
80100831:	eb fe                	jmp    80100831 <cprintf+0x181>
80100833:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80100838:	b9 28 00 00 00       	mov    $0x28,%ecx
        s = "(null)";
8010083d:	bf b8 82 10 80       	mov    $0x801082b8,%edi
80100842:	eb d6                	jmp    8010081a <cprintf+0x16a>
80100844:	fa                   	cli
    for(;;)
80100845:	eb fe                	jmp    80100845 <cprintf+0x195>
80100847:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010084e:	00 
8010084f:	90                   	nop
80100850:	fa                   	cli
80100851:	eb fe                	jmp    80100851 <cprintf+0x1a1>
80100853:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80100858:	e8 a3 fb ff ff       	call   80100400 <consputc.part.0>
      for(; *s; s++)
8010085d:	0f be 43 01          	movsbl 0x1(%ebx),%eax
80100861:	83 c3 01             	add    $0x1,%ebx
80100864:	84 c0                	test   %al,%al
80100866:	75 be                	jne    80100826 <cprintf+0x176>
      if((s = (char*)*argp++) == 0)
80100868:	89 f0                	mov    %esi,%eax
8010086a:	8b 5d e0             	mov    -0x20(%ebp),%ebx
8010086d:	89 fe                	mov    %edi,%esi
8010086f:	89 c7                	mov    %eax,%edi
80100871:	e9 ac fe ff ff       	jmp    80100722 <cprintf+0x72>
80100876:	89 c8                	mov    %ecx,%eax
80100878:	e8 83 fb ff ff       	call   80100400 <consputc.part.0>
      break;
8010087d:	e9 a0 fe ff ff       	jmp    80100722 <cprintf+0x72>
      if((s = (char*)*argp++) == 0)
80100882:	89 c7                	mov    %eax,%edi
80100884:	e9 99 fe ff ff       	jmp    80100722 <cprintf+0x72>
    panic("null fmt");
80100889:	83 ec 0c             	sub    $0xc,%esp
8010088c:	68 bf 82 10 80       	push   $0x801082bf
80100891:	e8 ea fa ff ff       	call   80100380 <panic>
80100896:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010089d:	00 
8010089e:	66 90                	xchg   %ax,%ax

801008a0 <consoleintr>:
{
801008a0:	55                   	push   %ebp
801008a1:	89 e5                	mov    %esp,%ebp
801008a3:	57                   	push   %edi
  int c, doprocdump = 0;
801008a4:	31 ff                	xor    %edi,%edi
{
801008a6:	56                   	push   %esi
801008a7:	53                   	push   %ebx
801008a8:	83 ec 18             	sub    $0x18,%esp
801008ab:	8b 75 08             	mov    0x8(%ebp),%esi
  acquire(&cons.lock);
801008ae:	68 80 7f 13 80       	push   $0x80137f80
801008b3:	e8 e8 3d 00 00       	call   801046a0 <acquire>
  while((c = getc()) >= 0){
801008b8:	83 c4 10             	add    $0x10,%esp
801008bb:	ff d6                	call   *%esi
801008bd:	89 c3                	mov    %eax,%ebx
801008bf:	85 c0                	test   %eax,%eax
801008c1:	78 22                	js     801008e5 <consoleintr+0x45>
    switch(c){
801008c3:	83 fb 15             	cmp    $0x15,%ebx
801008c6:	74 47                	je     8010090f <consoleintr+0x6f>
801008c8:	7f 76                	jg     80100940 <consoleintr+0xa0>
801008ca:	83 fb 08             	cmp    $0x8,%ebx
801008cd:	74 76                	je     80100945 <consoleintr+0xa5>
801008cf:	83 fb 10             	cmp    $0x10,%ebx
801008d2:	0f 85 f8 00 00 00    	jne    801009d0 <consoleintr+0x130>
  while((c = getc()) >= 0){
801008d8:	ff d6                	call   *%esi
    switch(c){
801008da:	bf 01 00 00 00       	mov    $0x1,%edi
  while((c = getc()) >= 0){
801008df:	89 c3                	mov    %eax,%ebx
801008e1:	85 c0                	test   %eax,%eax
801008e3:	79 de                	jns    801008c3 <consoleintr+0x23>
  release(&cons.lock);
801008e5:	83 ec 0c             	sub    $0xc,%esp
801008e8:	68 80 7f 13 80       	push   $0x80137f80
801008ed:	e8 4e 3d 00 00       	call   80104640 <release>
  if(doprocdump) {
801008f2:	83 c4 10             	add    $0x10,%esp
801008f5:	85 ff                	test   %edi,%edi
801008f7:	0f 85 4b 01 00 00    	jne    80100a48 <consoleintr+0x1a8>
}
801008fd:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100900:	5b                   	pop    %ebx
80100901:	5e                   	pop    %esi
80100902:	5f                   	pop    %edi
80100903:	5d                   	pop    %ebp
80100904:	c3                   	ret
80100905:	b8 00 01 00 00       	mov    $0x100,%eax
8010090a:	e8 f1 fa ff ff       	call   80100400 <consputc.part.0>
      while(input.e != input.w &&
8010090f:	a1 68 7f 13 80       	mov    0x80137f68,%eax
80100914:	3b 05 64 7f 13 80    	cmp    0x80137f64,%eax
8010091a:	74 9f                	je     801008bb <consoleintr+0x1b>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
8010091c:	83 e8 01             	sub    $0x1,%eax
8010091f:	89 c2                	mov    %eax,%edx
80100921:	83 e2 7f             	and    $0x7f,%edx
      while(input.e != input.w &&
80100924:	80 ba e0 7e 13 80 0a 	cmpb   $0xa,-0x7fec8120(%edx)
8010092b:	74 8e                	je     801008bb <consoleintr+0x1b>
  if(panicked){
8010092d:	8b 15 b8 7f 13 80    	mov    0x80137fb8,%edx
        input.e--;
80100933:	a3 68 7f 13 80       	mov    %eax,0x80137f68
  if(panicked){
80100938:	85 d2                	test   %edx,%edx
8010093a:	74 c9                	je     80100905 <consoleintr+0x65>
8010093c:	fa                   	cli
    for(;;)
8010093d:	eb fe                	jmp    8010093d <consoleintr+0x9d>
8010093f:	90                   	nop
    switch(c){
80100940:	83 fb 7f             	cmp    $0x7f,%ebx
80100943:	75 2b                	jne    80100970 <consoleintr+0xd0>
      if(input.e != input.w){
80100945:	a1 68 7f 13 80       	mov    0x80137f68,%eax
8010094a:	3b 05 64 7f 13 80    	cmp    0x80137f64,%eax
80100950:	0f 84 65 ff ff ff    	je     801008bb <consoleintr+0x1b>
        input.e--;
80100956:	83 e8 01             	sub    $0x1,%eax
80100959:	a3 68 7f 13 80       	mov    %eax,0x80137f68
  if(panicked){
8010095e:	a1 b8 7f 13 80       	mov    0x80137fb8,%eax
80100963:	85 c0                	test   %eax,%eax
80100965:	0f 84 ce 00 00 00    	je     80100a39 <consoleintr+0x199>
8010096b:	fa                   	cli
    for(;;)
8010096c:	eb fe                	jmp    8010096c <consoleintr+0xcc>
8010096e:	66 90                	xchg   %ax,%ax
      if(c != 0 && input.e-input.r < INPUT_BUF){
80100970:	a1 68 7f 13 80       	mov    0x80137f68,%eax
80100975:	89 c2                	mov    %eax,%edx
80100977:	2b 15 60 7f 13 80    	sub    0x80137f60,%edx
8010097d:	83 fa 7f             	cmp    $0x7f,%edx
80100980:	0f 87 35 ff ff ff    	ja     801008bb <consoleintr+0x1b>
  if(panicked){
80100986:	8b 0d b8 7f 13 80    	mov    0x80137fb8,%ecx
        input.buf[input.e++ % INPUT_BUF] = c;
8010098c:	8d 50 01             	lea    0x1(%eax),%edx
8010098f:	83 e0 7f             	and    $0x7f,%eax
80100992:	89 15 68 7f 13 80    	mov    %edx,0x80137f68
80100998:	88 98 e0 7e 13 80    	mov    %bl,-0x7fec8120(%eax)
  if(panicked){
8010099e:	85 c9                	test   %ecx,%ecx
801009a0:	0f 85 ae 00 00 00    	jne    80100a54 <consoleintr+0x1b4>
801009a6:	89 d8                	mov    %ebx,%eax
801009a8:	e8 53 fa ff ff       	call   80100400 <consputc.part.0>
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
801009ad:	83 fb 0a             	cmp    $0xa,%ebx
801009b0:	74 68                	je     80100a1a <consoleintr+0x17a>
801009b2:	83 fb 04             	cmp    $0x4,%ebx
801009b5:	74 63                	je     80100a1a <consoleintr+0x17a>
801009b7:	a1 60 7f 13 80       	mov    0x80137f60,%eax
801009bc:	83 e8 80             	sub    $0xffffff80,%eax
801009bf:	39 05 68 7f 13 80    	cmp    %eax,0x80137f68
801009c5:	0f 85 f0 fe ff ff    	jne    801008bb <consoleintr+0x1b>
801009cb:	eb 52                	jmp    80100a1f <consoleintr+0x17f>
801009cd:	8d 76 00             	lea    0x0(%esi),%esi
      if(c != 0 && input.e-input.r < INPUT_BUF){
801009d0:	85 db                	test   %ebx,%ebx
801009d2:	0f 84 e3 fe ff ff    	je     801008bb <consoleintr+0x1b>
801009d8:	a1 68 7f 13 80       	mov    0x80137f68,%eax
801009dd:	89 c2                	mov    %eax,%edx
801009df:	2b 15 60 7f 13 80    	sub    0x80137f60,%edx
801009e5:	83 fa 7f             	cmp    $0x7f,%edx
801009e8:	0f 87 cd fe ff ff    	ja     801008bb <consoleintr+0x1b>
        input.buf[input.e++ % INPUT_BUF] = c;
801009ee:	8d 50 01             	lea    0x1(%eax),%edx
  if(panicked){
801009f1:	8b 0d b8 7f 13 80    	mov    0x80137fb8,%ecx
        input.buf[input.e++ % INPUT_BUF] = c;
801009f7:	83 e0 7f             	and    $0x7f,%eax
        c = (c == '\r') ? '\n' : c;
801009fa:	83 fb 0d             	cmp    $0xd,%ebx
801009fd:	75 93                	jne    80100992 <consoleintr+0xf2>
        input.buf[input.e++ % INPUT_BUF] = c;
801009ff:	89 15 68 7f 13 80    	mov    %edx,0x80137f68
80100a05:	c6 80 e0 7e 13 80 0a 	movb   $0xa,-0x7fec8120(%eax)
  if(panicked){
80100a0c:	85 c9                	test   %ecx,%ecx
80100a0e:	75 44                	jne    80100a54 <consoleintr+0x1b4>
80100a10:	b8 0a 00 00 00       	mov    $0xa,%eax
80100a15:	e8 e6 f9 ff ff       	call   80100400 <consputc.part.0>
          input.w = input.e;
80100a1a:	a1 68 7f 13 80       	mov    0x80137f68,%eax
          wakeup(&input.r);
80100a1f:	83 ec 0c             	sub    $0xc,%esp
          input.w = input.e;
80100a22:	a3 64 7f 13 80       	mov    %eax,0x80137f64
          wakeup(&input.r);
80100a27:	68 60 7f 13 80       	push   $0x80137f60
80100a2c:	e8 af 37 00 00       	call   801041e0 <wakeup>
80100a31:	83 c4 10             	add    $0x10,%esp
80100a34:	e9 82 fe ff ff       	jmp    801008bb <consoleintr+0x1b>
80100a39:	b8 00 01 00 00       	mov    $0x100,%eax
80100a3e:	e8 bd f9 ff ff       	call   80100400 <consputc.part.0>
80100a43:	e9 73 fe ff ff       	jmp    801008bb <consoleintr+0x1b>
}
80100a48:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100a4b:	5b                   	pop    %ebx
80100a4c:	5e                   	pop    %esi
80100a4d:	5f                   	pop    %edi
80100a4e:	5d                   	pop    %ebp
    procdump();  // now call procdump() wo. cons.lock held
80100a4f:	e9 6c 38 00 00       	jmp    801042c0 <procdump>
80100a54:	fa                   	cli
    for(;;)
80100a55:	eb fe                	jmp    80100a55 <consoleintr+0x1b5>
80100a57:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80100a5e:	00 
80100a5f:	90                   	nop

80100a60 <consoleinit>:

void
consoleinit(void)
{
80100a60:	55                   	push   %ebp
80100a61:	89 e5                	mov    %esp,%ebp
80100a63:	83 ec 10             	sub    $0x10,%esp
  initlock(&cons.lock, "console");
80100a66:	68 c8 82 10 80       	push   $0x801082c8
80100a6b:	68 80 7f 13 80       	push   $0x80137f80
80100a70:	e8 3b 3a 00 00       	call   801044b0 <initlock>

  devsw[CONSOLE].write = consolewrite;
  devsw[CONSOLE].read = consoleread;
  cons.locking = 1;

  ioapicenable(IRQ_KBD, 0);
80100a75:	58                   	pop    %eax
80100a76:	5a                   	pop    %edx
80100a77:	6a 00                	push   $0x0
80100a79:	6a 01                	push   $0x1
  devsw[CONSOLE].write = consolewrite;
80100a7b:	c7 05 6c 89 13 80 b0 	movl   $0x801005b0,0x8013896c
80100a82:	05 10 80 
  devsw[CONSOLE].read = consoleread;
80100a85:	c7 05 68 89 13 80 80 	movl   $0x80100280,0x80138968
80100a8c:	02 10 80 
  cons.locking = 1;
80100a8f:	c7 05 b4 7f 13 80 01 	movl   $0x1,0x80137fb4
80100a96:	00 00 00 
  ioapicenable(IRQ_KBD, 0);
80100a99:	e8 22 1a 00 00       	call   801024c0 <ioapicenable>
}
80100a9e:	83 c4 10             	add    $0x10,%esp
80100aa1:	c9                   	leave
80100aa2:	c3                   	ret
80100aa3:	66 90                	xchg   %ax,%ax
80100aa5:	66 90                	xchg   %ax,%ax
80100aa7:	66 90                	xchg   %ax,%ax
80100aa9:	66 90                	xchg   %ax,%ax
80100aab:	66 90                	xchg   %ax,%ax
80100aad:	66 90                	xchg   %ax,%ax
80100aaf:	90                   	nop

80100ab0 <exec>:
#include "x86.h"
#include "elf.h"

int
exec(char *path, char **argv)
{
80100ab0:	55                   	push   %ebp
80100ab1:	89 e5                	mov    %esp,%ebp
80100ab3:	57                   	push   %edi
80100ab4:	56                   	push   %esi
80100ab5:	53                   	push   %ebx
80100ab6:	81 ec 0c 01 00 00    	sub    $0x10c,%esp
  uint argc, sz, sp, ustack[3+MAXARG+1];
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pde_t *pgdir, *oldpgdir;
  struct proc *curproc = myproc();
80100abc:	e8 0f 2f 00 00       	call   801039d0 <myproc>
80100ac1:	89 85 ec fe ff ff    	mov    %eax,-0x114(%ebp)

  begin_op();
80100ac7:	e8 d4 22 00 00       	call   80102da0 <begin_op>

  if((ip = namei(path)) == 0){
80100acc:	83 ec 0c             	sub    $0xc,%esp
80100acf:	ff 75 08             	push   0x8(%ebp)
80100ad2:	e8 09 16 00 00       	call   801020e0 <namei>
80100ad7:	83 c4 10             	add    $0x10,%esp
80100ada:	85 c0                	test   %eax,%eax
80100adc:	0f 84 86 03 00 00    	je     80100e68 <exec+0x3b8>
    end_op();
    cprintf("exec: fail\n");
    return -1;
  }
  ilock(ip);
80100ae2:	83 ec 0c             	sub    $0xc,%esp
80100ae5:	89 c7                	mov    %eax,%edi
80100ae7:	50                   	push   %eax
80100ae8:	e8 13 0d 00 00       	call   80101800 <ilock>
  pgdir = 0;

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) != sizeof(elf))
80100aed:	8d 85 24 ff ff ff    	lea    -0xdc(%ebp),%eax
80100af3:	6a 34                	push   $0x34
80100af5:	6a 00                	push   $0x0
80100af7:	50                   	push   %eax
80100af8:	57                   	push   %edi
80100af9:	e8 12 10 00 00       	call   80101b10 <readi>
80100afe:	83 c4 20             	add    $0x20,%esp
80100b01:	83 f8 34             	cmp    $0x34,%eax
80100b04:	0f 85 01 01 00 00    	jne    80100c0b <exec+0x15b>
    goto bad;
  if(elf.magic != ELF_MAGIC)
80100b0a:	81 bd 24 ff ff ff 7f 	cmpl   $0x464c457f,-0xdc(%ebp)
80100b11:	45 4c 46 
80100b14:	0f 85 f1 00 00 00    	jne    80100c0b <exec+0x15b>
    goto bad;

  if((pgdir = setupkvm()) == 0)
80100b1a:	e8 e1 65 00 00       	call   80107100 <setupkvm>
80100b1f:	89 85 f4 fe ff ff    	mov    %eax,-0x10c(%ebp)
80100b25:	85 c0                	test   %eax,%eax
80100b27:	0f 84 de 00 00 00    	je     80100c0b <exec+0x15b>
    goto bad;

  // Load program into memory.
  sz = 0;
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100b2d:	66 83 bd 50 ff ff ff 	cmpw   $0x0,-0xb0(%ebp)
80100b34:	00 
80100b35:	8b b5 40 ff ff ff    	mov    -0xc0(%ebp),%esi
80100b3b:	0f 84 f7 02 00 00    	je     80100e38 <exec+0x388>
  sz = 0;
80100b41:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
80100b48:	00 00 00 
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100b4b:	31 db                	xor    %ebx,%ebx
80100b4d:	e9 8c 00 00 00       	jmp    80100bde <exec+0x12e>
80100b52:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
      goto bad;
    if(ph.type != ELF_PROG_LOAD)
80100b58:	83 bd 04 ff ff ff 01 	cmpl   $0x1,-0xfc(%ebp)
80100b5f:	75 6c                	jne    80100bcd <exec+0x11d>
      continue;
    if(ph.memsz < ph.filesz)
80100b61:	8b 85 18 ff ff ff    	mov    -0xe8(%ebp),%eax
80100b67:	3b 85 14 ff ff ff    	cmp    -0xec(%ebp),%eax
80100b6d:	0f 82 87 00 00 00    	jb     80100bfa <exec+0x14a>
      goto bad;
    if(ph.vaddr + ph.memsz < ph.vaddr)
80100b73:	03 85 0c ff ff ff    	add    -0xf4(%ebp),%eax
80100b79:	72 7f                	jb     80100bfa <exec+0x14a>
      goto bad;
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
80100b7b:	83 ec 04             	sub    $0x4,%esp
80100b7e:	50                   	push   %eax
80100b7f:	ff b5 f0 fe ff ff    	push   -0x110(%ebp)
80100b85:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
80100b8b:	e8 b0 63 00 00       	call   80106f40 <allocuvm>
80100b90:	83 c4 10             	add    $0x10,%esp
80100b93:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
80100b99:	85 c0                	test   %eax,%eax
80100b9b:	74 5d                	je     80100bfa <exec+0x14a>
      goto bad;
    if(ph.vaddr % PGSIZE != 0)
80100b9d:	8b 85 0c ff ff ff    	mov    -0xf4(%ebp),%eax
80100ba3:	a9 ff 0f 00 00       	test   $0xfff,%eax
80100ba8:	75 50                	jne    80100bfa <exec+0x14a>
      goto bad;
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
80100baa:	83 ec 0c             	sub    $0xc,%esp
80100bad:	ff b5 14 ff ff ff    	push   -0xec(%ebp)
80100bb3:	ff b5 08 ff ff ff    	push   -0xf8(%ebp)
80100bb9:	57                   	push   %edi
80100bba:	50                   	push   %eax
80100bbb:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
80100bc1:	e8 aa 62 00 00       	call   80106e70 <loaduvm>
80100bc6:	83 c4 20             	add    $0x20,%esp
80100bc9:	85 c0                	test   %eax,%eax
80100bcb:	78 2d                	js     80100bfa <exec+0x14a>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100bcd:	0f b7 85 50 ff ff ff 	movzwl -0xb0(%ebp),%eax
80100bd4:	83 c3 01             	add    $0x1,%ebx
80100bd7:	83 c6 20             	add    $0x20,%esi
80100bda:	39 d8                	cmp    %ebx,%eax
80100bdc:	7e 52                	jle    80100c30 <exec+0x180>
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
80100bde:	8d 85 04 ff ff ff    	lea    -0xfc(%ebp),%eax
80100be4:	6a 20                	push   $0x20
80100be6:	56                   	push   %esi
80100be7:	50                   	push   %eax
80100be8:	57                   	push   %edi
80100be9:	e8 22 0f 00 00       	call   80101b10 <readi>
80100bee:	83 c4 10             	add    $0x10,%esp
80100bf1:	83 f8 20             	cmp    $0x20,%eax
80100bf4:	0f 84 5e ff ff ff    	je     80100b58 <exec+0xa8>
  freevm(oldpgdir);
  return 0;

 bad:
  if(pgdir)
    freevm(pgdir);
80100bfa:	83 ec 0c             	sub    $0xc,%esp
80100bfd:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
80100c03:	e8 78 64 00 00       	call   80107080 <freevm>
  if(ip){
80100c08:	83 c4 10             	add    $0x10,%esp
    iunlockput(ip);
80100c0b:	83 ec 0c             	sub    $0xc,%esp
80100c0e:	57                   	push   %edi
80100c0f:	e8 7c 0e 00 00       	call   80101a90 <iunlockput>
    end_op();
80100c14:	e8 f7 21 00 00       	call   80102e10 <end_op>
80100c19:	83 c4 10             	add    $0x10,%esp
    return -1;
80100c1c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  return -1;
}
80100c21:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100c24:	5b                   	pop    %ebx
80100c25:	5e                   	pop    %esi
80100c26:	5f                   	pop    %edi
80100c27:	5d                   	pop    %ebp
80100c28:	c3                   	ret
80100c29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  sz = PGROUNDUP(sz);
80100c30:	8b b5 f0 fe ff ff    	mov    -0x110(%ebp),%esi
80100c36:	81 c6 ff 0f 00 00    	add    $0xfff,%esi
80100c3c:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80100c42:	8d 9e 00 20 00 00    	lea    0x2000(%esi),%ebx
  iunlockput(ip);
80100c48:	83 ec 0c             	sub    $0xc,%esp
80100c4b:	57                   	push   %edi
80100c4c:	e8 3f 0e 00 00       	call   80101a90 <iunlockput>
  end_op();
80100c51:	e8 ba 21 00 00       	call   80102e10 <end_op>
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80100c56:	83 c4 0c             	add    $0xc,%esp
80100c59:	53                   	push   %ebx
80100c5a:	56                   	push   %esi
80100c5b:	8b b5 f4 fe ff ff    	mov    -0x10c(%ebp),%esi
80100c61:	56                   	push   %esi
80100c62:	e8 d9 62 00 00       	call   80106f40 <allocuvm>
80100c67:	83 c4 10             	add    $0x10,%esp
80100c6a:	89 c7                	mov    %eax,%edi
80100c6c:	85 c0                	test   %eax,%eax
80100c6e:	0f 84 86 00 00 00    	je     80100cfa <exec+0x24a>
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100c74:	83 ec 08             	sub    $0x8,%esp
80100c77:	8d 80 00 e0 ff ff    	lea    -0x2000(%eax),%eax
  sp = sz;
80100c7d:	89 fb                	mov    %edi,%ebx
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100c7f:	50                   	push   %eax
80100c80:	56                   	push   %esi
  for(argc = 0; argv[argc]; argc++) {
80100c81:	31 f6                	xor    %esi,%esi
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100c83:	e8 18 65 00 00       	call   801071a0 <clearpteu>
  for(argc = 0; argv[argc]; argc++) {
80100c88:	8b 45 0c             	mov    0xc(%ebp),%eax
80100c8b:	83 c4 10             	add    $0x10,%esp
80100c8e:	8b 10                	mov    (%eax),%edx
80100c90:	85 d2                	test   %edx,%edx
80100c92:	0f 84 ac 01 00 00    	je     80100e44 <exec+0x394>
80100c98:	89 bd f0 fe ff ff    	mov    %edi,-0x110(%ebp)
80100c9e:	8b 7d 0c             	mov    0xc(%ebp),%edi
80100ca1:	eb 23                	jmp    80100cc6 <exec+0x216>
80100ca3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80100ca8:	8d 46 01             	lea    0x1(%esi),%eax
    ustack[3+argc] = sp;
80100cab:	89 9c b5 64 ff ff ff 	mov    %ebx,-0x9c(%ebp,%esi,4)
80100cb2:	8d 8d 58 ff ff ff    	lea    -0xa8(%ebp),%ecx
  for(argc = 0; argv[argc]; argc++) {
80100cb8:	8b 14 87             	mov    (%edi,%eax,4),%edx
80100cbb:	85 d2                	test   %edx,%edx
80100cbd:	74 51                	je     80100d10 <exec+0x260>
    if(argc >= MAXARG)
80100cbf:	83 f8 20             	cmp    $0x20,%eax
80100cc2:	74 36                	je     80100cfa <exec+0x24a>
80100cc4:	89 c6                	mov    %eax,%esi
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100cc6:	83 ec 0c             	sub    $0xc,%esp
80100cc9:	52                   	push   %edx
80100cca:	e8 c1 3c 00 00       	call   80104990 <strlen>
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100ccf:	5a                   	pop    %edx
80100cd0:	ff 34 b7             	push   (%edi,%esi,4)
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100cd3:	29 c3                	sub    %eax,%ebx
80100cd5:	83 eb 01             	sub    $0x1,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100cd8:	e8 b3 3c 00 00       	call   80104990 <strlen>
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100cdd:	83 e3 fc             	and    $0xfffffffc,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100ce0:	83 c0 01             	add    $0x1,%eax
80100ce3:	50                   	push   %eax
80100ce4:	ff 34 b7             	push   (%edi,%esi,4)
80100ce7:	53                   	push   %ebx
80100ce8:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
80100cee:	e8 cd 66 00 00       	call   801073c0 <copyout>
80100cf3:	83 c4 20             	add    $0x20,%esp
80100cf6:	85 c0                	test   %eax,%eax
80100cf8:	79 ae                	jns    80100ca8 <exec+0x1f8>
    freevm(pgdir);
80100cfa:	83 ec 0c             	sub    $0xc,%esp
80100cfd:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
80100d03:	e8 78 63 00 00       	call   80107080 <freevm>
80100d08:	83 c4 10             	add    $0x10,%esp
80100d0b:	e9 0c ff ff ff       	jmp    80100c1c <exec+0x16c>
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100d10:	8d 14 b5 08 00 00 00 	lea    0x8(,%esi,4),%edx
  ustack[3+argc] = 0;
80100d17:	8b bd f0 fe ff ff    	mov    -0x110(%ebp),%edi
80100d1d:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
80100d23:	8d 46 04             	lea    0x4(%esi),%eax
  sp -= (3+argc+1) * 4;
80100d26:	8d 72 0c             	lea    0xc(%edx),%esi
  ustack[3+argc] = 0;
80100d29:	c7 84 85 58 ff ff ff 	movl   $0x0,-0xa8(%ebp,%eax,4)
80100d30:	00 00 00 00 
  ustack[1] = argc;
80100d34:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
  ustack[0] = 0xffffffff;  // fake return PC
80100d3a:	c7 85 58 ff ff ff ff 	movl   $0xffffffff,-0xa8(%ebp)
80100d41:	ff ff ff 
  ustack[1] = argc;
80100d44:	89 85 5c ff ff ff    	mov    %eax,-0xa4(%ebp)
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100d4a:	89 d8                	mov    %ebx,%eax
  sp -= (3+argc+1) * 4;
80100d4c:	29 f3                	sub    %esi,%ebx
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100d4e:	29 d0                	sub    %edx,%eax
80100d50:	89 85 60 ff ff ff    	mov    %eax,-0xa0(%ebp)
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100d56:	56                   	push   %esi
80100d57:	51                   	push   %ecx
80100d58:	53                   	push   %ebx
80100d59:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
80100d5f:	e8 5c 66 00 00       	call   801073c0 <copyout>
80100d64:	83 c4 10             	add    $0x10,%esp
80100d67:	85 c0                	test   %eax,%eax
80100d69:	78 8f                	js     80100cfa <exec+0x24a>
  for(last=s=path; *s; s++)
80100d6b:	8b 45 08             	mov    0x8(%ebp),%eax
80100d6e:	8b 55 08             	mov    0x8(%ebp),%edx
80100d71:	0f b6 00             	movzbl (%eax),%eax
80100d74:	84 c0                	test   %al,%al
80100d76:	74 17                	je     80100d8f <exec+0x2df>
80100d78:	89 d1                	mov    %edx,%ecx
80100d7a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      last = s+1;
80100d80:	83 c1 01             	add    $0x1,%ecx
80100d83:	3c 2f                	cmp    $0x2f,%al
  for(last=s=path; *s; s++)
80100d85:	0f b6 01             	movzbl (%ecx),%eax
      last = s+1;
80100d88:	0f 44 d1             	cmove  %ecx,%edx
  for(last=s=path; *s; s++)
80100d8b:	84 c0                	test   %al,%al
80100d8d:	75 f1                	jne    80100d80 <exec+0x2d0>
  safestrcpy(curproc->name, last, sizeof(curproc->name));
80100d8f:	83 ec 04             	sub    $0x4,%esp
80100d92:	6a 10                	push   $0x10
80100d94:	52                   	push   %edx
80100d95:	8b b5 ec fe ff ff    	mov    -0x114(%ebp),%esi
80100d9b:	8d 46 6c             	lea    0x6c(%esi),%eax
80100d9e:	50                   	push   %eax
80100d9f:	e8 ac 3b 00 00       	call   80104950 <safestrcpy>
  oldpgdir = curproc->pgdir;
80100da4:	8b 4e 04             	mov    0x4(%esi),%ecx
  curproc->sz = sz;
80100da7:	89 3e                	mov    %edi,(%esi)
80100da9:	83 c4 10             	add    $0x10,%esp
  curproc->tf->eip = elf.entry;  // main
80100dac:	8b 46 18             	mov    0x18(%esi),%eax
  oldpgdir = curproc->pgdir;
80100daf:	89 8d f0 fe ff ff    	mov    %ecx,-0x110(%ebp)
  curproc->pgdir = pgdir;
80100db5:	8b 8d f4 fe ff ff    	mov    -0x10c(%ebp),%ecx
80100dbb:	89 4e 04             	mov    %ecx,0x4(%esi)
  curproc->tf->eip = elf.entry;  // main
80100dbe:	8b 95 3c ff ff ff    	mov    -0xc4(%ebp),%edx
80100dc4:	89 50 38             	mov    %edx,0x38(%eax)
  curproc->tf->esp = sp;
80100dc7:	8b 46 18             	mov    0x18(%esi),%eax
  int last_shmid = -2;
80100dca:	ba fe ff ff ff       	mov    $0xfffffffe,%edx
  curproc->tf->esp = sp;
80100dcf:	89 58 44             	mov    %ebx,0x44(%eax)
  for (i = 0; i < 4096; i++) {
80100dd2:	8d 5e 7c             	lea    0x7c(%esi),%ebx
80100dd5:	8d b6 7c 80 00 00    	lea    0x807c(%esi),%esi
80100ddb:	eb 0a                	jmp    80100de7 <exec+0x337>
80100ddd:	8d 76 00             	lea    0x0(%esi),%esi
80100de0:	83 c3 08             	add    $0x8,%ebx
80100de3:	39 de                	cmp    %ebx,%esi
80100de5:	74 2d                	je     80100e14 <exec+0x364>
    if(curproc->shmsegs[i].isAttached == 1){
80100de7:	83 3b 01             	cmpl   $0x1,(%ebx)
80100dea:	75 f4                	jne    80100de0 <exec+0x330>
      int temp_shmid = curproc->shmsegs[i].shmid;
80100dec:	8b 7b 04             	mov    0x4(%ebx),%edi
      curproc->shmsegs[i].isAttached = 0;
80100def:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
      curproc->shmsegs[i].shmid = -1;
80100df5:	c7 43 04 ff ff ff ff 	movl   $0xffffffff,0x4(%ebx)
      if(temp_shmid == last_shmid){
80100dfc:	39 d7                	cmp    %edx,%edi
80100dfe:	74 10                	je     80100e10 <exec+0x360>
        updateShmSeg(temp_shmid, -1, 1);
80100e00:	83 ec 04             	sub    $0x4,%esp
80100e03:	6a 01                	push   $0x1
80100e05:	6a ff                	push   $0xffffffff
80100e07:	57                   	push   %edi
80100e08:	e8 e3 66 00 00       	call   801074f0 <updateShmSeg>
80100e0d:	83 c4 10             	add    $0x10,%esp
  int last_shmid = -2;
80100e10:	89 fa                	mov    %edi,%edx
80100e12:	eb cc                	jmp    80100de0 <exec+0x330>
  switchuvm(curproc);
80100e14:	83 ec 0c             	sub    $0xc,%esp
80100e17:	ff b5 ec fe ff ff    	push   -0x114(%ebp)
80100e1d:	e8 be 5e 00 00       	call   80106ce0 <switchuvm>
  freevm(oldpgdir);
80100e22:	58                   	pop    %eax
80100e23:	ff b5 f0 fe ff ff    	push   -0x110(%ebp)
80100e29:	e8 52 62 00 00       	call   80107080 <freevm>
  return 0;
80100e2e:	83 c4 10             	add    $0x10,%esp
80100e31:	31 c0                	xor    %eax,%eax
80100e33:	e9 e9 fd ff ff       	jmp    80100c21 <exec+0x171>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100e38:	bb 00 20 00 00       	mov    $0x2000,%ebx
80100e3d:	31 f6                	xor    %esi,%esi
80100e3f:	e9 04 fe ff ff       	jmp    80100c48 <exec+0x198>
  for(argc = 0; argv[argc]; argc++) {
80100e44:	be 10 00 00 00       	mov    $0x10,%esi
80100e49:	ba 04 00 00 00       	mov    $0x4,%edx
80100e4e:	b8 03 00 00 00       	mov    $0x3,%eax
80100e53:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
80100e5a:	00 00 00 
80100e5d:	8d 8d 58 ff ff ff    	lea    -0xa8(%ebp),%ecx
80100e63:	e9 c1 fe ff ff       	jmp    80100d29 <exec+0x279>
    end_op();
80100e68:	e8 a3 1f 00 00       	call   80102e10 <end_op>
    cprintf("exec: fail\n");
80100e6d:	83 ec 0c             	sub    $0xc,%esp
80100e70:	68 d0 82 10 80       	push   $0x801082d0
80100e75:	e8 36 f8 ff ff       	call   801006b0 <cprintf>
    return -1;
80100e7a:	83 c4 10             	add    $0x10,%esp
80100e7d:	e9 9a fd ff ff       	jmp    80100c1c <exec+0x16c>
80100e82:	66 90                	xchg   %ax,%ax
80100e84:	66 90                	xchg   %ax,%ax
80100e86:	66 90                	xchg   %ax,%ax
80100e88:	66 90                	xchg   %ax,%ax
80100e8a:	66 90                	xchg   %ax,%ax
80100e8c:	66 90                	xchg   %ax,%ax
80100e8e:	66 90                	xchg   %ax,%ax

80100e90 <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
80100e90:	55                   	push   %ebp
80100e91:	89 e5                	mov    %esp,%ebp
80100e93:	83 ec 10             	sub    $0x10,%esp
  initlock(&ftable.lock, "ftable");
80100e96:	68 dc 82 10 80       	push   $0x801082dc
80100e9b:	68 c0 7f 13 80       	push   $0x80137fc0
80100ea0:	e8 0b 36 00 00       	call   801044b0 <initlock>
}
80100ea5:	83 c4 10             	add    $0x10,%esp
80100ea8:	c9                   	leave
80100ea9:	c3                   	ret
80100eaa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80100eb0 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
80100eb0:	55                   	push   %ebp
80100eb1:	89 e5                	mov    %esp,%ebp
80100eb3:	53                   	push   %ebx
  struct file *f;

  acquire(&ftable.lock);
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100eb4:	bb f4 7f 13 80       	mov    $0x80137ff4,%ebx
{
80100eb9:	83 ec 10             	sub    $0x10,%esp
  acquire(&ftable.lock);
80100ebc:	68 c0 7f 13 80       	push   $0x80137fc0
80100ec1:	e8 da 37 00 00       	call   801046a0 <acquire>
80100ec6:	83 c4 10             	add    $0x10,%esp
80100ec9:	eb 10                	jmp    80100edb <filealloc+0x2b>
80100ecb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100ed0:	83 c3 18             	add    $0x18,%ebx
80100ed3:	81 fb 54 89 13 80    	cmp    $0x80138954,%ebx
80100ed9:	74 25                	je     80100f00 <filealloc+0x50>
    if(f->ref == 0){
80100edb:	8b 43 04             	mov    0x4(%ebx),%eax
80100ede:	85 c0                	test   %eax,%eax
80100ee0:	75 ee                	jne    80100ed0 <filealloc+0x20>
      f->ref = 1;
      release(&ftable.lock);
80100ee2:	83 ec 0c             	sub    $0xc,%esp
      f->ref = 1;
80100ee5:	c7 43 04 01 00 00 00 	movl   $0x1,0x4(%ebx)
      release(&ftable.lock);
80100eec:	68 c0 7f 13 80       	push   $0x80137fc0
80100ef1:	e8 4a 37 00 00       	call   80104640 <release>
      return f;
    }
  }
  release(&ftable.lock);
  return 0;
}
80100ef6:	89 d8                	mov    %ebx,%eax
      return f;
80100ef8:	83 c4 10             	add    $0x10,%esp
}
80100efb:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100efe:	c9                   	leave
80100eff:	c3                   	ret
  release(&ftable.lock);
80100f00:	83 ec 0c             	sub    $0xc,%esp
  return 0;
80100f03:	31 db                	xor    %ebx,%ebx
  release(&ftable.lock);
80100f05:	68 c0 7f 13 80       	push   $0x80137fc0
80100f0a:	e8 31 37 00 00       	call   80104640 <release>
}
80100f0f:	89 d8                	mov    %ebx,%eax
  return 0;
80100f11:	83 c4 10             	add    $0x10,%esp
}
80100f14:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100f17:	c9                   	leave
80100f18:	c3                   	ret
80100f19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80100f20 <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
80100f20:	55                   	push   %ebp
80100f21:	89 e5                	mov    %esp,%ebp
80100f23:	53                   	push   %ebx
80100f24:	83 ec 10             	sub    $0x10,%esp
80100f27:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ftable.lock);
80100f2a:	68 c0 7f 13 80       	push   $0x80137fc0
80100f2f:	e8 6c 37 00 00       	call   801046a0 <acquire>
  if(f->ref < 1)
80100f34:	8b 43 04             	mov    0x4(%ebx),%eax
80100f37:	83 c4 10             	add    $0x10,%esp
80100f3a:	85 c0                	test   %eax,%eax
80100f3c:	7e 1a                	jle    80100f58 <filedup+0x38>
    panic("filedup");
  f->ref++;
80100f3e:	83 c0 01             	add    $0x1,%eax
  release(&ftable.lock);
80100f41:	83 ec 0c             	sub    $0xc,%esp
  f->ref++;
80100f44:	89 43 04             	mov    %eax,0x4(%ebx)
  release(&ftable.lock);
80100f47:	68 c0 7f 13 80       	push   $0x80137fc0
80100f4c:	e8 ef 36 00 00       	call   80104640 <release>
  return f;
}
80100f51:	89 d8                	mov    %ebx,%eax
80100f53:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100f56:	c9                   	leave
80100f57:	c3                   	ret
    panic("filedup");
80100f58:	83 ec 0c             	sub    $0xc,%esp
80100f5b:	68 e3 82 10 80       	push   $0x801082e3
80100f60:	e8 1b f4 ff ff       	call   80100380 <panic>
80100f65:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80100f6c:	00 
80100f6d:	8d 76 00             	lea    0x0(%esi),%esi

80100f70 <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
80100f70:	55                   	push   %ebp
80100f71:	89 e5                	mov    %esp,%ebp
80100f73:	57                   	push   %edi
80100f74:	56                   	push   %esi
80100f75:	53                   	push   %ebx
80100f76:	83 ec 28             	sub    $0x28,%esp
80100f79:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct file ff;

  acquire(&ftable.lock);
80100f7c:	68 c0 7f 13 80       	push   $0x80137fc0
80100f81:	e8 1a 37 00 00       	call   801046a0 <acquire>
  if(f->ref < 1)
80100f86:	8b 53 04             	mov    0x4(%ebx),%edx
80100f89:	83 c4 10             	add    $0x10,%esp
80100f8c:	85 d2                	test   %edx,%edx
80100f8e:	0f 8e a5 00 00 00    	jle    80101039 <fileclose+0xc9>
    panic("fileclose");
  if(--f->ref > 0){
80100f94:	83 ea 01             	sub    $0x1,%edx
80100f97:	89 53 04             	mov    %edx,0x4(%ebx)
80100f9a:	75 44                	jne    80100fe0 <fileclose+0x70>
    release(&ftable.lock);
    return;
  }
  ff = *f;
80100f9c:	0f b6 43 09          	movzbl 0x9(%ebx),%eax
  f->ref = 0;
  f->type = FD_NONE;
  release(&ftable.lock);
80100fa0:	83 ec 0c             	sub    $0xc,%esp
  ff = *f;
80100fa3:	8b 3b                	mov    (%ebx),%edi
  f->type = FD_NONE;
80100fa5:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  ff = *f;
80100fab:	8b 73 0c             	mov    0xc(%ebx),%esi
80100fae:	88 45 e7             	mov    %al,-0x19(%ebp)
80100fb1:	8b 43 10             	mov    0x10(%ebx),%eax
80100fb4:	89 45 e0             	mov    %eax,-0x20(%ebp)
  release(&ftable.lock);
80100fb7:	68 c0 7f 13 80       	push   $0x80137fc0
80100fbc:	e8 7f 36 00 00       	call   80104640 <release>

  if(ff.type == FD_PIPE)
80100fc1:	83 c4 10             	add    $0x10,%esp
80100fc4:	83 ff 01             	cmp    $0x1,%edi
80100fc7:	74 57                	je     80101020 <fileclose+0xb0>
    pipeclose(ff.pipe, ff.writable);
  else if(ff.type == FD_INODE){
80100fc9:	83 ff 02             	cmp    $0x2,%edi
80100fcc:	74 2a                	je     80100ff8 <fileclose+0x88>
    begin_op();
    iput(ff.ip);
    end_op();
  }
}
80100fce:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100fd1:	5b                   	pop    %ebx
80100fd2:	5e                   	pop    %esi
80100fd3:	5f                   	pop    %edi
80100fd4:	5d                   	pop    %ebp
80100fd5:	c3                   	ret
80100fd6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80100fdd:	00 
80100fde:	66 90                	xchg   %ax,%ax
    release(&ftable.lock);
80100fe0:	c7 45 08 c0 7f 13 80 	movl   $0x80137fc0,0x8(%ebp)
}
80100fe7:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100fea:	5b                   	pop    %ebx
80100feb:	5e                   	pop    %esi
80100fec:	5f                   	pop    %edi
80100fed:	5d                   	pop    %ebp
    release(&ftable.lock);
80100fee:	e9 4d 36 00 00       	jmp    80104640 <release>
80100ff3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    begin_op();
80100ff8:	e8 a3 1d 00 00       	call   80102da0 <begin_op>
    iput(ff.ip);
80100ffd:	83 ec 0c             	sub    $0xc,%esp
80101000:	ff 75 e0             	push   -0x20(%ebp)
80101003:	e8 28 09 00 00       	call   80101930 <iput>
    end_op();
80101008:	83 c4 10             	add    $0x10,%esp
}
8010100b:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010100e:	5b                   	pop    %ebx
8010100f:	5e                   	pop    %esi
80101010:	5f                   	pop    %edi
80101011:	5d                   	pop    %ebp
    end_op();
80101012:	e9 f9 1d 00 00       	jmp    80102e10 <end_op>
80101017:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010101e:	00 
8010101f:	90                   	nop
    pipeclose(ff.pipe, ff.writable);
80101020:	0f be 5d e7          	movsbl -0x19(%ebp),%ebx
80101024:	83 ec 08             	sub    $0x8,%esp
80101027:	53                   	push   %ebx
80101028:	56                   	push   %esi
80101029:	e8 42 25 00 00       	call   80103570 <pipeclose>
8010102e:	83 c4 10             	add    $0x10,%esp
}
80101031:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101034:	5b                   	pop    %ebx
80101035:	5e                   	pop    %esi
80101036:	5f                   	pop    %edi
80101037:	5d                   	pop    %ebp
80101038:	c3                   	ret
    panic("fileclose");
80101039:	83 ec 0c             	sub    $0xc,%esp
8010103c:	68 eb 82 10 80       	push   $0x801082eb
80101041:	e8 3a f3 ff ff       	call   80100380 <panic>
80101046:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010104d:	00 
8010104e:	66 90                	xchg   %ax,%ax

80101050 <filestat>:

// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
80101050:	55                   	push   %ebp
80101051:	89 e5                	mov    %esp,%ebp
80101053:	53                   	push   %ebx
80101054:	83 ec 04             	sub    $0x4,%esp
80101057:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(f->type == FD_INODE){
8010105a:	83 3b 02             	cmpl   $0x2,(%ebx)
8010105d:	75 31                	jne    80101090 <filestat+0x40>
    ilock(f->ip);
8010105f:	83 ec 0c             	sub    $0xc,%esp
80101062:	ff 73 10             	push   0x10(%ebx)
80101065:	e8 96 07 00 00       	call   80101800 <ilock>
    stati(f->ip, st);
8010106a:	58                   	pop    %eax
8010106b:	5a                   	pop    %edx
8010106c:	ff 75 0c             	push   0xc(%ebp)
8010106f:	ff 73 10             	push   0x10(%ebx)
80101072:	e8 69 0a 00 00       	call   80101ae0 <stati>
    iunlock(f->ip);
80101077:	59                   	pop    %ecx
80101078:	ff 73 10             	push   0x10(%ebx)
8010107b:	e8 60 08 00 00       	call   801018e0 <iunlock>
    return 0;
  }
  return -1;
}
80101080:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    return 0;
80101083:	83 c4 10             	add    $0x10,%esp
80101086:	31 c0                	xor    %eax,%eax
}
80101088:	c9                   	leave
80101089:	c3                   	ret
8010108a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80101090:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  return -1;
80101093:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80101098:	c9                   	leave
80101099:	c3                   	ret
8010109a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801010a0 <fileread>:

// Read from file f.
int
fileread(struct file *f, char *addr, int n)
{
801010a0:	55                   	push   %ebp
801010a1:	89 e5                	mov    %esp,%ebp
801010a3:	57                   	push   %edi
801010a4:	56                   	push   %esi
801010a5:	53                   	push   %ebx
801010a6:	83 ec 0c             	sub    $0xc,%esp
801010a9:	8b 5d 08             	mov    0x8(%ebp),%ebx
801010ac:	8b 75 0c             	mov    0xc(%ebp),%esi
801010af:	8b 7d 10             	mov    0x10(%ebp),%edi
  int r;

  if(f->readable == 0)
801010b2:	80 7b 08 00          	cmpb   $0x0,0x8(%ebx)
801010b6:	74 60                	je     80101118 <fileread+0x78>
    return -1;
  if(f->type == FD_PIPE)
801010b8:	8b 03                	mov    (%ebx),%eax
801010ba:	83 f8 01             	cmp    $0x1,%eax
801010bd:	74 41                	je     80101100 <fileread+0x60>
    return piperead(f->pipe, addr, n);
  if(f->type == FD_INODE){
801010bf:	83 f8 02             	cmp    $0x2,%eax
801010c2:	75 5b                	jne    8010111f <fileread+0x7f>
    ilock(f->ip);
801010c4:	83 ec 0c             	sub    $0xc,%esp
801010c7:	ff 73 10             	push   0x10(%ebx)
801010ca:	e8 31 07 00 00       	call   80101800 <ilock>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
801010cf:	57                   	push   %edi
801010d0:	ff 73 14             	push   0x14(%ebx)
801010d3:	56                   	push   %esi
801010d4:	ff 73 10             	push   0x10(%ebx)
801010d7:	e8 34 0a 00 00       	call   80101b10 <readi>
801010dc:	83 c4 20             	add    $0x20,%esp
801010df:	89 c6                	mov    %eax,%esi
801010e1:	85 c0                	test   %eax,%eax
801010e3:	7e 03                	jle    801010e8 <fileread+0x48>
      f->off += r;
801010e5:	01 43 14             	add    %eax,0x14(%ebx)
    iunlock(f->ip);
801010e8:	83 ec 0c             	sub    $0xc,%esp
801010eb:	ff 73 10             	push   0x10(%ebx)
801010ee:	e8 ed 07 00 00       	call   801018e0 <iunlock>
    return r;
801010f3:	83 c4 10             	add    $0x10,%esp
  }
  panic("fileread");
}
801010f6:	8d 65 f4             	lea    -0xc(%ebp),%esp
801010f9:	89 f0                	mov    %esi,%eax
801010fb:	5b                   	pop    %ebx
801010fc:	5e                   	pop    %esi
801010fd:	5f                   	pop    %edi
801010fe:	5d                   	pop    %ebp
801010ff:	c3                   	ret
    return piperead(f->pipe, addr, n);
80101100:	8b 43 0c             	mov    0xc(%ebx),%eax
80101103:	89 45 08             	mov    %eax,0x8(%ebp)
}
80101106:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101109:	5b                   	pop    %ebx
8010110a:	5e                   	pop    %esi
8010110b:	5f                   	pop    %edi
8010110c:	5d                   	pop    %ebp
    return piperead(f->pipe, addr, n);
8010110d:	e9 1e 26 00 00       	jmp    80103730 <piperead>
80101112:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
80101118:	be ff ff ff ff       	mov    $0xffffffff,%esi
8010111d:	eb d7                	jmp    801010f6 <fileread+0x56>
  panic("fileread");
8010111f:	83 ec 0c             	sub    $0xc,%esp
80101122:	68 f5 82 10 80       	push   $0x801082f5
80101127:	e8 54 f2 ff ff       	call   80100380 <panic>
8010112c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101130 <filewrite>:

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
80101130:	55                   	push   %ebp
80101131:	89 e5                	mov    %esp,%ebp
80101133:	57                   	push   %edi
80101134:	56                   	push   %esi
80101135:	53                   	push   %ebx
80101136:	83 ec 1c             	sub    $0x1c,%esp
80101139:	8b 45 0c             	mov    0xc(%ebp),%eax
8010113c:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010113f:	89 45 dc             	mov    %eax,-0x24(%ebp)
80101142:	8b 45 10             	mov    0x10(%ebp),%eax
  int r;

  if(f->writable == 0)
80101145:	80 7b 09 00          	cmpb   $0x0,0x9(%ebx)
{
80101149:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(f->writable == 0)
8010114c:	0f 84 bb 00 00 00    	je     8010120d <filewrite+0xdd>
    return -1;
  if(f->type == FD_PIPE)
80101152:	8b 03                	mov    (%ebx),%eax
80101154:	83 f8 01             	cmp    $0x1,%eax
80101157:	0f 84 bf 00 00 00    	je     8010121c <filewrite+0xec>
    return pipewrite(f->pipe, addr, n);
  if(f->type == FD_INODE){
8010115d:	83 f8 02             	cmp    $0x2,%eax
80101160:	0f 85 c8 00 00 00    	jne    8010122e <filewrite+0xfe>
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * 512;
    int i = 0;
    while(i < n){
80101166:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    int i = 0;
80101169:	31 f6                	xor    %esi,%esi
    while(i < n){
8010116b:	85 c0                	test   %eax,%eax
8010116d:	7f 30                	jg     8010119f <filewrite+0x6f>
8010116f:	e9 94 00 00 00       	jmp    80101208 <filewrite+0xd8>
80101174:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        n1 = max;

      begin_op();
      ilock(f->ip);
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
        f->off += r;
80101178:	01 43 14             	add    %eax,0x14(%ebx)
      iunlock(f->ip);
8010117b:	83 ec 0c             	sub    $0xc,%esp
        f->off += r;
8010117e:	89 45 e0             	mov    %eax,-0x20(%ebp)
      iunlock(f->ip);
80101181:	ff 73 10             	push   0x10(%ebx)
80101184:	e8 57 07 00 00       	call   801018e0 <iunlock>
      end_op();
80101189:	e8 82 1c 00 00       	call   80102e10 <end_op>

      if(r < 0)
        break;
      if(r != n1)
8010118e:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101191:	83 c4 10             	add    $0x10,%esp
80101194:	39 c7                	cmp    %eax,%edi
80101196:	75 5c                	jne    801011f4 <filewrite+0xc4>
        panic("short filewrite");
      i += r;
80101198:	01 fe                	add    %edi,%esi
    while(i < n){
8010119a:	39 75 e4             	cmp    %esi,-0x1c(%ebp)
8010119d:	7e 69                	jle    80101208 <filewrite+0xd8>
      int n1 = n - i;
8010119f:	8b 7d e4             	mov    -0x1c(%ebp),%edi
      if(n1 > max)
801011a2:	b8 00 06 00 00       	mov    $0x600,%eax
      int n1 = n - i;
801011a7:	29 f7                	sub    %esi,%edi
      if(n1 > max)
801011a9:	39 c7                	cmp    %eax,%edi
801011ab:	0f 4f f8             	cmovg  %eax,%edi
      begin_op();
801011ae:	e8 ed 1b 00 00       	call   80102da0 <begin_op>
      ilock(f->ip);
801011b3:	83 ec 0c             	sub    $0xc,%esp
801011b6:	ff 73 10             	push   0x10(%ebx)
801011b9:	e8 42 06 00 00       	call   80101800 <ilock>
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
801011be:	57                   	push   %edi
801011bf:	ff 73 14             	push   0x14(%ebx)
801011c2:	8b 45 dc             	mov    -0x24(%ebp),%eax
801011c5:	01 f0                	add    %esi,%eax
801011c7:	50                   	push   %eax
801011c8:	ff 73 10             	push   0x10(%ebx)
801011cb:	e8 40 0a 00 00       	call   80101c10 <writei>
801011d0:	83 c4 20             	add    $0x20,%esp
801011d3:	85 c0                	test   %eax,%eax
801011d5:	7f a1                	jg     80101178 <filewrite+0x48>
801011d7:	89 45 e0             	mov    %eax,-0x20(%ebp)
      iunlock(f->ip);
801011da:	83 ec 0c             	sub    $0xc,%esp
801011dd:	ff 73 10             	push   0x10(%ebx)
801011e0:	e8 fb 06 00 00       	call   801018e0 <iunlock>
      end_op();
801011e5:	e8 26 1c 00 00       	call   80102e10 <end_op>
      if(r < 0)
801011ea:	8b 45 e0             	mov    -0x20(%ebp),%eax
801011ed:	83 c4 10             	add    $0x10,%esp
801011f0:	85 c0                	test   %eax,%eax
801011f2:	75 14                	jne    80101208 <filewrite+0xd8>
        panic("short filewrite");
801011f4:	83 ec 0c             	sub    $0xc,%esp
801011f7:	68 fe 82 10 80       	push   $0x801082fe
801011fc:	e8 7f f1 ff ff       	call   80100380 <panic>
80101201:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    }
    return i == n ? n : -1;
80101208:	39 75 e4             	cmp    %esi,-0x1c(%ebp)
8010120b:	74 05                	je     80101212 <filewrite+0xe2>
8010120d:	be ff ff ff ff       	mov    $0xffffffff,%esi
  }
  panic("filewrite");
}
80101212:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101215:	89 f0                	mov    %esi,%eax
80101217:	5b                   	pop    %ebx
80101218:	5e                   	pop    %esi
80101219:	5f                   	pop    %edi
8010121a:	5d                   	pop    %ebp
8010121b:	c3                   	ret
    return pipewrite(f->pipe, addr, n);
8010121c:	8b 43 0c             	mov    0xc(%ebx),%eax
8010121f:	89 45 08             	mov    %eax,0x8(%ebp)
}
80101222:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101225:	5b                   	pop    %ebx
80101226:	5e                   	pop    %esi
80101227:	5f                   	pop    %edi
80101228:	5d                   	pop    %ebp
    return pipewrite(f->pipe, addr, n);
80101229:	e9 e2 23 00 00       	jmp    80103610 <pipewrite>
  panic("filewrite");
8010122e:	83 ec 0c             	sub    $0xc,%esp
80101231:	68 04 83 10 80       	push   $0x80108304
80101236:	e8 45 f1 ff ff       	call   80100380 <panic>
8010123b:	66 90                	xchg   %ax,%ax
8010123d:	66 90                	xchg   %ax,%ax
8010123f:	90                   	nop

80101240 <balloc>:
// Blocks.

// Allocate a zeroed disk block.
static uint
balloc(uint dev)
{
80101240:	55                   	push   %ebp
80101241:	89 e5                	mov    %esp,%ebp
80101243:	57                   	push   %edi
80101244:	56                   	push   %esi
80101245:	53                   	push   %ebx
80101246:	83 ec 1c             	sub    $0x1c,%esp
  int b, bi, m;
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
80101249:	8b 0d 14 a6 13 80    	mov    0x8013a614,%ecx
{
8010124f:	89 45 dc             	mov    %eax,-0x24(%ebp)
  for(b = 0; b < sb.size; b += BPB){
80101252:	85 c9                	test   %ecx,%ecx
80101254:	0f 84 8c 00 00 00    	je     801012e6 <balloc+0xa6>
8010125a:	31 ff                	xor    %edi,%edi
    bp = bread(dev, BBLOCK(b, sb));
8010125c:	89 f8                	mov    %edi,%eax
8010125e:	83 ec 08             	sub    $0x8,%esp
80101261:	89 fe                	mov    %edi,%esi
80101263:	c1 f8 0c             	sar    $0xc,%eax
80101266:	03 05 2c a6 13 80    	add    0x8013a62c,%eax
8010126c:	50                   	push   %eax
8010126d:	ff 75 dc             	push   -0x24(%ebp)
80101270:	e8 5b ee ff ff       	call   801000d0 <bread>
80101275:	83 c4 10             	add    $0x10,%esp
80101278:	89 7d d8             	mov    %edi,-0x28(%ebp)
8010127b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
8010127e:	a1 14 a6 13 80       	mov    0x8013a614,%eax
80101283:	89 45 e0             	mov    %eax,-0x20(%ebp)
80101286:	31 c0                	xor    %eax,%eax
80101288:	eb 32                	jmp    801012bc <balloc+0x7c>
8010128a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      m = 1 << (bi % 8);
80101290:	89 c1                	mov    %eax,%ecx
80101292:	bb 01 00 00 00       	mov    $0x1,%ebx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
80101297:	8b 7d e4             	mov    -0x1c(%ebp),%edi
      m = 1 << (bi % 8);
8010129a:	83 e1 07             	and    $0x7,%ecx
8010129d:	d3 e3                	shl    %cl,%ebx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
8010129f:	89 c1                	mov    %eax,%ecx
801012a1:	c1 f9 03             	sar    $0x3,%ecx
801012a4:	0f b6 7c 0f 5c       	movzbl 0x5c(%edi,%ecx,1),%edi
801012a9:	89 fa                	mov    %edi,%edx
801012ab:	85 df                	test   %ebx,%edi
801012ad:	74 49                	je     801012f8 <balloc+0xb8>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
801012af:	83 c0 01             	add    $0x1,%eax
801012b2:	83 c6 01             	add    $0x1,%esi
801012b5:	3d 00 10 00 00       	cmp    $0x1000,%eax
801012ba:	74 07                	je     801012c3 <balloc+0x83>
801012bc:	8b 55 e0             	mov    -0x20(%ebp),%edx
801012bf:	39 d6                	cmp    %edx,%esi
801012c1:	72 cd                	jb     80101290 <balloc+0x50>
        brelse(bp);
        bzero(dev, b + bi);
        return b + bi;
      }
    }
    brelse(bp);
801012c3:	8b 7d d8             	mov    -0x28(%ebp),%edi
801012c6:	83 ec 0c             	sub    $0xc,%esp
801012c9:	ff 75 e4             	push   -0x1c(%ebp)
  for(b = 0; b < sb.size; b += BPB){
801012cc:	81 c7 00 10 00 00    	add    $0x1000,%edi
    brelse(bp);
801012d2:	e8 19 ef ff ff       	call   801001f0 <brelse>
  for(b = 0; b < sb.size; b += BPB){
801012d7:	83 c4 10             	add    $0x10,%esp
801012da:	3b 3d 14 a6 13 80    	cmp    0x8013a614,%edi
801012e0:	0f 82 76 ff ff ff    	jb     8010125c <balloc+0x1c>
  }
  panic("balloc: out of blocks");
801012e6:	83 ec 0c             	sub    $0xc,%esp
801012e9:	68 0e 83 10 80       	push   $0x8010830e
801012ee:	e8 8d f0 ff ff       	call   80100380 <panic>
801012f3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
        bp->data[bi/8] |= m;  // Mark block in use.
801012f8:	8b 7d e4             	mov    -0x1c(%ebp),%edi
        log_write(bp);
801012fb:	83 ec 0c             	sub    $0xc,%esp
        bp->data[bi/8] |= m;  // Mark block in use.
801012fe:	09 da                	or     %ebx,%edx
80101300:	88 54 0f 5c          	mov    %dl,0x5c(%edi,%ecx,1)
        log_write(bp);
80101304:	57                   	push   %edi
80101305:	e8 76 1c 00 00       	call   80102f80 <log_write>
        brelse(bp);
8010130a:	89 3c 24             	mov    %edi,(%esp)
8010130d:	e8 de ee ff ff       	call   801001f0 <brelse>
  bp = bread(dev, bno);
80101312:	58                   	pop    %eax
80101313:	5a                   	pop    %edx
80101314:	56                   	push   %esi
80101315:	ff 75 dc             	push   -0x24(%ebp)
80101318:	e8 b3 ed ff ff       	call   801000d0 <bread>
  memset(bp->data, 0, BSIZE);
8010131d:	83 c4 0c             	add    $0xc,%esp
  bp = bread(dev, bno);
80101320:	89 c3                	mov    %eax,%ebx
  memset(bp->data, 0, BSIZE);
80101322:	8d 40 5c             	lea    0x5c(%eax),%eax
80101325:	68 00 02 00 00       	push   $0x200
8010132a:	6a 00                	push   $0x0
8010132c:	50                   	push   %eax
8010132d:	e8 6e 34 00 00       	call   801047a0 <memset>
  log_write(bp);
80101332:	89 1c 24             	mov    %ebx,(%esp)
80101335:	e8 46 1c 00 00       	call   80102f80 <log_write>
  brelse(bp);
8010133a:	89 1c 24             	mov    %ebx,(%esp)
8010133d:	e8 ae ee ff ff       	call   801001f0 <brelse>
}
80101342:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101345:	89 f0                	mov    %esi,%eax
80101347:	5b                   	pop    %ebx
80101348:	5e                   	pop    %esi
80101349:	5f                   	pop    %edi
8010134a:	5d                   	pop    %ebp
8010134b:	c3                   	ret
8010134c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101350 <iget>:
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
80101350:	55                   	push   %ebp
80101351:	89 e5                	mov    %esp,%ebp
80101353:	57                   	push   %edi
  struct inode *ip, *empty;

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
80101354:	31 ff                	xor    %edi,%edi
{
80101356:	56                   	push   %esi
80101357:	89 c6                	mov    %eax,%esi
80101359:	53                   	push   %ebx
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
8010135a:	bb f4 89 13 80       	mov    $0x801389f4,%ebx
{
8010135f:	83 ec 28             	sub    $0x28,%esp
80101362:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  acquire(&icache.lock);
80101365:	68 c0 89 13 80       	push   $0x801389c0
8010136a:	e8 31 33 00 00       	call   801046a0 <acquire>
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
8010136f:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  acquire(&icache.lock);
80101372:	83 c4 10             	add    $0x10,%esp
80101375:	eb 1b                	jmp    80101392 <iget+0x42>
80101377:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010137e:	00 
8010137f:	90                   	nop
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80101380:	39 33                	cmp    %esi,(%ebx)
80101382:	74 6c                	je     801013f0 <iget+0xa0>
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101384:	81 c3 90 00 00 00    	add    $0x90,%ebx
8010138a:	81 fb 14 a6 13 80    	cmp    $0x8013a614,%ebx
80101390:	74 26                	je     801013b8 <iget+0x68>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80101392:	8b 43 08             	mov    0x8(%ebx),%eax
80101395:	85 c0                	test   %eax,%eax
80101397:	7f e7                	jg     80101380 <iget+0x30>
      ip->ref++;
      release(&icache.lock);
      return ip;
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
80101399:	85 ff                	test   %edi,%edi
8010139b:	75 e7                	jne    80101384 <iget+0x34>
8010139d:	85 c0                	test   %eax,%eax
8010139f:	75 76                	jne    80101417 <iget+0xc7>
      empty = ip;
801013a1:	89 df                	mov    %ebx,%edi
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801013a3:	81 c3 90 00 00 00    	add    $0x90,%ebx
801013a9:	81 fb 14 a6 13 80    	cmp    $0x8013a614,%ebx
801013af:	75 e1                	jne    80101392 <iget+0x42>
801013b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  }

  // Recycle an inode cache entry.
  if(empty == 0)
801013b8:	85 ff                	test   %edi,%edi
801013ba:	74 79                	je     80101435 <iget+0xe5>
  ip = empty;
  ip->dev = dev;
  ip->inum = inum;
  ip->ref = 1;
  ip->valid = 0;
  release(&icache.lock);
801013bc:	83 ec 0c             	sub    $0xc,%esp
  ip->dev = dev;
801013bf:	89 37                	mov    %esi,(%edi)
  ip->inum = inum;
801013c1:	89 57 04             	mov    %edx,0x4(%edi)
  ip->ref = 1;
801013c4:	c7 47 08 01 00 00 00 	movl   $0x1,0x8(%edi)
  ip->valid = 0;
801013cb:	c7 47 4c 00 00 00 00 	movl   $0x0,0x4c(%edi)
  release(&icache.lock);
801013d2:	68 c0 89 13 80       	push   $0x801389c0
801013d7:	e8 64 32 00 00       	call   80104640 <release>

  return ip;
801013dc:	83 c4 10             	add    $0x10,%esp
}
801013df:	8d 65 f4             	lea    -0xc(%ebp),%esp
801013e2:	89 f8                	mov    %edi,%eax
801013e4:	5b                   	pop    %ebx
801013e5:	5e                   	pop    %esi
801013e6:	5f                   	pop    %edi
801013e7:	5d                   	pop    %ebp
801013e8:	c3                   	ret
801013e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
801013f0:	39 53 04             	cmp    %edx,0x4(%ebx)
801013f3:	75 8f                	jne    80101384 <iget+0x34>
      ip->ref++;
801013f5:	83 c0 01             	add    $0x1,%eax
      release(&icache.lock);
801013f8:	83 ec 0c             	sub    $0xc,%esp
      return ip;
801013fb:	89 df                	mov    %ebx,%edi
      ip->ref++;
801013fd:	89 43 08             	mov    %eax,0x8(%ebx)
      release(&icache.lock);
80101400:	68 c0 89 13 80       	push   $0x801389c0
80101405:	e8 36 32 00 00       	call   80104640 <release>
      return ip;
8010140a:	83 c4 10             	add    $0x10,%esp
}
8010140d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101410:	89 f8                	mov    %edi,%eax
80101412:	5b                   	pop    %ebx
80101413:	5e                   	pop    %esi
80101414:	5f                   	pop    %edi
80101415:	5d                   	pop    %ebp
80101416:	c3                   	ret
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101417:	81 c3 90 00 00 00    	add    $0x90,%ebx
8010141d:	81 fb 14 a6 13 80    	cmp    $0x8013a614,%ebx
80101423:	74 10                	je     80101435 <iget+0xe5>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80101425:	8b 43 08             	mov    0x8(%ebx),%eax
80101428:	85 c0                	test   %eax,%eax
8010142a:	0f 8f 50 ff ff ff    	jg     80101380 <iget+0x30>
80101430:	e9 68 ff ff ff       	jmp    8010139d <iget+0x4d>
    panic("iget: no inodes");
80101435:	83 ec 0c             	sub    $0xc,%esp
80101438:	68 24 83 10 80       	push   $0x80108324
8010143d:	e8 3e ef ff ff       	call   80100380 <panic>
80101442:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80101449:	00 
8010144a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80101450 <bfree>:
{
80101450:	55                   	push   %ebp
80101451:	89 c1                	mov    %eax,%ecx
  bp = bread(dev, BBLOCK(b, sb));
80101453:	89 d0                	mov    %edx,%eax
80101455:	c1 e8 0c             	shr    $0xc,%eax
{
80101458:	89 e5                	mov    %esp,%ebp
8010145a:	56                   	push   %esi
8010145b:	53                   	push   %ebx
  bp = bread(dev, BBLOCK(b, sb));
8010145c:	03 05 2c a6 13 80    	add    0x8013a62c,%eax
{
80101462:	89 d3                	mov    %edx,%ebx
  bp = bread(dev, BBLOCK(b, sb));
80101464:	83 ec 08             	sub    $0x8,%esp
80101467:	50                   	push   %eax
80101468:	51                   	push   %ecx
80101469:	e8 62 ec ff ff       	call   801000d0 <bread>
  m = 1 << (bi % 8);
8010146e:	89 d9                	mov    %ebx,%ecx
  if((bp->data[bi/8] & m) == 0)
80101470:	c1 fb 03             	sar    $0x3,%ebx
80101473:	83 c4 10             	add    $0x10,%esp
  bp = bread(dev, BBLOCK(b, sb));
80101476:	89 c6                	mov    %eax,%esi
  m = 1 << (bi % 8);
80101478:	83 e1 07             	and    $0x7,%ecx
8010147b:	b8 01 00 00 00       	mov    $0x1,%eax
  if((bp->data[bi/8] & m) == 0)
80101480:	81 e3 ff 01 00 00    	and    $0x1ff,%ebx
  m = 1 << (bi % 8);
80101486:	d3 e0                	shl    %cl,%eax
  if((bp->data[bi/8] & m) == 0)
80101488:	0f b6 4c 1e 5c       	movzbl 0x5c(%esi,%ebx,1),%ecx
8010148d:	85 c1                	test   %eax,%ecx
8010148f:	74 23                	je     801014b4 <bfree+0x64>
  bp->data[bi/8] &= ~m;
80101491:	f7 d0                	not    %eax
  log_write(bp);
80101493:	83 ec 0c             	sub    $0xc,%esp
  bp->data[bi/8] &= ~m;
80101496:	21 c8                	and    %ecx,%eax
80101498:	88 44 1e 5c          	mov    %al,0x5c(%esi,%ebx,1)
  log_write(bp);
8010149c:	56                   	push   %esi
8010149d:	e8 de 1a 00 00       	call   80102f80 <log_write>
  brelse(bp);
801014a2:	89 34 24             	mov    %esi,(%esp)
801014a5:	e8 46 ed ff ff       	call   801001f0 <brelse>
}
801014aa:	83 c4 10             	add    $0x10,%esp
801014ad:	8d 65 f8             	lea    -0x8(%ebp),%esp
801014b0:	5b                   	pop    %ebx
801014b1:	5e                   	pop    %esi
801014b2:	5d                   	pop    %ebp
801014b3:	c3                   	ret
    panic("freeing free block");
801014b4:	83 ec 0c             	sub    $0xc,%esp
801014b7:	68 34 83 10 80       	push   $0x80108334
801014bc:	e8 bf ee ff ff       	call   80100380 <panic>
801014c1:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801014c8:	00 
801014c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801014d0 <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
801014d0:	55                   	push   %ebp
801014d1:	89 e5                	mov    %esp,%ebp
801014d3:	57                   	push   %edi
801014d4:	56                   	push   %esi
801014d5:	89 c6                	mov    %eax,%esi
801014d7:	53                   	push   %ebx
801014d8:	83 ec 1c             	sub    $0x1c,%esp
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
801014db:	83 fa 0b             	cmp    $0xb,%edx
801014de:	0f 86 8c 00 00 00    	jbe    80101570 <bmap+0xa0>
    if((addr = ip->addrs[bn]) == 0)
      ip->addrs[bn] = addr = balloc(ip->dev);
    return addr;
  }
  bn -= NDIRECT;
801014e4:	8d 5a f4             	lea    -0xc(%edx),%ebx

  if(bn < NINDIRECT){
801014e7:	83 fb 7f             	cmp    $0x7f,%ebx
801014ea:	0f 87 a2 00 00 00    	ja     80101592 <bmap+0xc2>
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
801014f0:	8b 80 8c 00 00 00    	mov    0x8c(%eax),%eax
801014f6:	85 c0                	test   %eax,%eax
801014f8:	74 5e                	je     80101558 <bmap+0x88>
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    bp = bread(ip->dev, addr);
801014fa:	83 ec 08             	sub    $0x8,%esp
801014fd:	50                   	push   %eax
801014fe:	ff 36                	push   (%esi)
80101500:	e8 cb eb ff ff       	call   801000d0 <bread>
    a = (uint*)bp->data;
    if((addr = a[bn]) == 0){
80101505:	83 c4 10             	add    $0x10,%esp
80101508:	8d 5c 98 5c          	lea    0x5c(%eax,%ebx,4),%ebx
    bp = bread(ip->dev, addr);
8010150c:	89 c2                	mov    %eax,%edx
    if((addr = a[bn]) == 0){
8010150e:	8b 3b                	mov    (%ebx),%edi
80101510:	85 ff                	test   %edi,%edi
80101512:	74 1c                	je     80101530 <bmap+0x60>
      a[bn] = addr = balloc(ip->dev);
      log_write(bp);
    }
    brelse(bp);
80101514:	83 ec 0c             	sub    $0xc,%esp
80101517:	52                   	push   %edx
80101518:	e8 d3 ec ff ff       	call   801001f0 <brelse>
8010151d:	83 c4 10             	add    $0x10,%esp
    return addr;
  }

  panic("bmap: out of range");
}
80101520:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101523:	89 f8                	mov    %edi,%eax
80101525:	5b                   	pop    %ebx
80101526:	5e                   	pop    %esi
80101527:	5f                   	pop    %edi
80101528:	5d                   	pop    %ebp
80101529:	c3                   	ret
8010152a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80101530:	89 45 e4             	mov    %eax,-0x1c(%ebp)
      a[bn] = addr = balloc(ip->dev);
80101533:	8b 06                	mov    (%esi),%eax
80101535:	e8 06 fd ff ff       	call   80101240 <balloc>
      log_write(bp);
8010153a:	8b 55 e4             	mov    -0x1c(%ebp),%edx
8010153d:	83 ec 0c             	sub    $0xc,%esp
      a[bn] = addr = balloc(ip->dev);
80101540:	89 03                	mov    %eax,(%ebx)
80101542:	89 c7                	mov    %eax,%edi
      log_write(bp);
80101544:	52                   	push   %edx
80101545:	e8 36 1a 00 00       	call   80102f80 <log_write>
8010154a:	8b 55 e4             	mov    -0x1c(%ebp),%edx
8010154d:	83 c4 10             	add    $0x10,%esp
80101550:	eb c2                	jmp    80101514 <bmap+0x44>
80101552:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
80101558:	8b 06                	mov    (%esi),%eax
8010155a:	e8 e1 fc ff ff       	call   80101240 <balloc>
8010155f:	89 86 8c 00 00 00    	mov    %eax,0x8c(%esi)
80101565:	eb 93                	jmp    801014fa <bmap+0x2a>
80101567:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010156e:	00 
8010156f:	90                   	nop
    if((addr = ip->addrs[bn]) == 0)
80101570:	8d 5a 14             	lea    0x14(%edx),%ebx
80101573:	8b 7c 98 0c          	mov    0xc(%eax,%ebx,4),%edi
80101577:	85 ff                	test   %edi,%edi
80101579:	75 a5                	jne    80101520 <bmap+0x50>
      ip->addrs[bn] = addr = balloc(ip->dev);
8010157b:	8b 00                	mov    (%eax),%eax
8010157d:	e8 be fc ff ff       	call   80101240 <balloc>
80101582:	89 44 9e 0c          	mov    %eax,0xc(%esi,%ebx,4)
80101586:	89 c7                	mov    %eax,%edi
}
80101588:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010158b:	5b                   	pop    %ebx
8010158c:	89 f8                	mov    %edi,%eax
8010158e:	5e                   	pop    %esi
8010158f:	5f                   	pop    %edi
80101590:	5d                   	pop    %ebp
80101591:	c3                   	ret
  panic("bmap: out of range");
80101592:	83 ec 0c             	sub    $0xc,%esp
80101595:	68 47 83 10 80       	push   $0x80108347
8010159a:	e8 e1 ed ff ff       	call   80100380 <panic>
8010159f:	90                   	nop

801015a0 <readsb>:
{
801015a0:	55                   	push   %ebp
801015a1:	89 e5                	mov    %esp,%ebp
801015a3:	56                   	push   %esi
801015a4:	53                   	push   %ebx
801015a5:	8b 75 0c             	mov    0xc(%ebp),%esi
  bp = bread(dev, 1);
801015a8:	83 ec 08             	sub    $0x8,%esp
801015ab:	6a 01                	push   $0x1
801015ad:	ff 75 08             	push   0x8(%ebp)
801015b0:	e8 1b eb ff ff       	call   801000d0 <bread>
  memmove(sb, bp->data, sizeof(*sb));
801015b5:	83 c4 0c             	add    $0xc,%esp
  bp = bread(dev, 1);
801015b8:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb));
801015ba:	8d 40 5c             	lea    0x5c(%eax),%eax
801015bd:	6a 1c                	push   $0x1c
801015bf:	50                   	push   %eax
801015c0:	56                   	push   %esi
801015c1:	e8 6a 32 00 00       	call   80104830 <memmove>
  brelse(bp);
801015c6:	83 c4 10             	add    $0x10,%esp
801015c9:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
801015cc:	8d 65 f8             	lea    -0x8(%ebp),%esp
801015cf:	5b                   	pop    %ebx
801015d0:	5e                   	pop    %esi
801015d1:	5d                   	pop    %ebp
  brelse(bp);
801015d2:	e9 19 ec ff ff       	jmp    801001f0 <brelse>
801015d7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801015de:	00 
801015df:	90                   	nop

801015e0 <iinit>:
{
801015e0:	55                   	push   %ebp
801015e1:	89 e5                	mov    %esp,%ebp
801015e3:	53                   	push   %ebx
801015e4:	bb 00 8a 13 80       	mov    $0x80138a00,%ebx
801015e9:	83 ec 0c             	sub    $0xc,%esp
  initlock(&icache.lock, "icache");
801015ec:	68 5a 83 10 80       	push   $0x8010835a
801015f1:	68 c0 89 13 80       	push   $0x801389c0
801015f6:	e8 b5 2e 00 00       	call   801044b0 <initlock>
  for(i = 0; i < NINODE; i++) {
801015fb:	83 c4 10             	add    $0x10,%esp
801015fe:	66 90                	xchg   %ax,%ax
    initsleeplock(&icache.inode[i].lock, "inode");
80101600:	83 ec 08             	sub    $0x8,%esp
80101603:	68 61 83 10 80       	push   $0x80108361
80101608:	53                   	push   %ebx
  for(i = 0; i < NINODE; i++) {
80101609:	81 c3 90 00 00 00    	add    $0x90,%ebx
    initsleeplock(&icache.inode[i].lock, "inode");
8010160f:	e8 6c 2d 00 00       	call   80104380 <initsleeplock>
  for(i = 0; i < NINODE; i++) {
80101614:	83 c4 10             	add    $0x10,%esp
80101617:	81 fb 20 a6 13 80    	cmp    $0x8013a620,%ebx
8010161d:	75 e1                	jne    80101600 <iinit+0x20>
  bp = bread(dev, 1);
8010161f:	83 ec 08             	sub    $0x8,%esp
80101622:	6a 01                	push   $0x1
80101624:	ff 75 08             	push   0x8(%ebp)
80101627:	e8 a4 ea ff ff       	call   801000d0 <bread>
  memmove(sb, bp->data, sizeof(*sb));
8010162c:	83 c4 0c             	add    $0xc,%esp
  bp = bread(dev, 1);
8010162f:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb));
80101631:	8d 40 5c             	lea    0x5c(%eax),%eax
80101634:	6a 1c                	push   $0x1c
80101636:	50                   	push   %eax
80101637:	68 14 a6 13 80       	push   $0x8013a614
8010163c:	e8 ef 31 00 00       	call   80104830 <memmove>
  brelse(bp);
80101641:	89 1c 24             	mov    %ebx,(%esp)
80101644:	e8 a7 eb ff ff       	call   801001f0 <brelse>
  cprintf("sb: size %d nblocks %d ninodes %d nlog %d logstart %d\
80101649:	ff 35 2c a6 13 80    	push   0x8013a62c
8010164f:	ff 35 28 a6 13 80    	push   0x8013a628
80101655:	ff 35 24 a6 13 80    	push   0x8013a624
8010165b:	ff 35 20 a6 13 80    	push   0x8013a620
80101661:	ff 35 1c a6 13 80    	push   0x8013a61c
80101667:	ff 35 18 a6 13 80    	push   0x8013a618
8010166d:	ff 35 14 a6 13 80    	push   0x8013a614
80101673:	68 78 88 10 80       	push   $0x80108878
80101678:	e8 33 f0 ff ff       	call   801006b0 <cprintf>
}
8010167d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101680:	83 c4 30             	add    $0x30,%esp
80101683:	c9                   	leave
80101684:	c3                   	ret
80101685:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010168c:	00 
8010168d:	8d 76 00             	lea    0x0(%esi),%esi

80101690 <ialloc>:
{
80101690:	55                   	push   %ebp
80101691:	89 e5                	mov    %esp,%ebp
80101693:	57                   	push   %edi
80101694:	56                   	push   %esi
80101695:	53                   	push   %ebx
80101696:	83 ec 1c             	sub    $0x1c,%esp
80101699:	8b 45 0c             	mov    0xc(%ebp),%eax
  for(inum = 1; inum < sb.ninodes; inum++){
8010169c:	83 3d 1c a6 13 80 01 	cmpl   $0x1,0x8013a61c
{
801016a3:	8b 75 08             	mov    0x8(%ebp),%esi
801016a6:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  for(inum = 1; inum < sb.ninodes; inum++){
801016a9:	0f 86 91 00 00 00    	jbe    80101740 <ialloc+0xb0>
801016af:	bf 01 00 00 00       	mov    $0x1,%edi
801016b4:	eb 21                	jmp    801016d7 <ialloc+0x47>
801016b6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801016bd:	00 
801016be:	66 90                	xchg   %ax,%ax
    brelse(bp);
801016c0:	83 ec 0c             	sub    $0xc,%esp
  for(inum = 1; inum < sb.ninodes; inum++){
801016c3:	83 c7 01             	add    $0x1,%edi
    brelse(bp);
801016c6:	53                   	push   %ebx
801016c7:	e8 24 eb ff ff       	call   801001f0 <brelse>
  for(inum = 1; inum < sb.ninodes; inum++){
801016cc:	83 c4 10             	add    $0x10,%esp
801016cf:	3b 3d 1c a6 13 80    	cmp    0x8013a61c,%edi
801016d5:	73 69                	jae    80101740 <ialloc+0xb0>
    bp = bread(dev, IBLOCK(inum, sb));
801016d7:	89 f8                	mov    %edi,%eax
801016d9:	83 ec 08             	sub    $0x8,%esp
801016dc:	c1 e8 03             	shr    $0x3,%eax
801016df:	03 05 28 a6 13 80    	add    0x8013a628,%eax
801016e5:	50                   	push   %eax
801016e6:	56                   	push   %esi
801016e7:	e8 e4 e9 ff ff       	call   801000d0 <bread>
    if(dip->type == 0){  // a free inode
801016ec:	83 c4 10             	add    $0x10,%esp
    bp = bread(dev, IBLOCK(inum, sb));
801016ef:	89 c3                	mov    %eax,%ebx
    dip = (struct dinode*)bp->data + inum%IPB;
801016f1:	89 f8                	mov    %edi,%eax
801016f3:	83 e0 07             	and    $0x7,%eax
801016f6:	c1 e0 06             	shl    $0x6,%eax
801016f9:	8d 4c 03 5c          	lea    0x5c(%ebx,%eax,1),%ecx
    if(dip->type == 0){  // a free inode
801016fd:	66 83 39 00          	cmpw   $0x0,(%ecx)
80101701:	75 bd                	jne    801016c0 <ialloc+0x30>
      memset(dip, 0, sizeof(*dip));
80101703:	83 ec 04             	sub    $0x4,%esp
80101706:	6a 40                	push   $0x40
80101708:	6a 00                	push   $0x0
8010170a:	51                   	push   %ecx
8010170b:	89 4d e0             	mov    %ecx,-0x20(%ebp)
8010170e:	e8 8d 30 00 00       	call   801047a0 <memset>
      dip->type = type;
80101713:	0f b7 45 e4          	movzwl -0x1c(%ebp),%eax
80101717:	8b 4d e0             	mov    -0x20(%ebp),%ecx
8010171a:	66 89 01             	mov    %ax,(%ecx)
      log_write(bp);   // mark it allocated on the disk
8010171d:	89 1c 24             	mov    %ebx,(%esp)
80101720:	e8 5b 18 00 00       	call   80102f80 <log_write>
      brelse(bp);
80101725:	89 1c 24             	mov    %ebx,(%esp)
80101728:	e8 c3 ea ff ff       	call   801001f0 <brelse>
      return iget(dev, inum);
8010172d:	83 c4 10             	add    $0x10,%esp
}
80101730:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return iget(dev, inum);
80101733:	89 fa                	mov    %edi,%edx
}
80101735:	5b                   	pop    %ebx
      return iget(dev, inum);
80101736:	89 f0                	mov    %esi,%eax
}
80101738:	5e                   	pop    %esi
80101739:	5f                   	pop    %edi
8010173a:	5d                   	pop    %ebp
      return iget(dev, inum);
8010173b:	e9 10 fc ff ff       	jmp    80101350 <iget>
  panic("ialloc: no inodes");
80101740:	83 ec 0c             	sub    $0xc,%esp
80101743:	68 67 83 10 80       	push   $0x80108367
80101748:	e8 33 ec ff ff       	call   80100380 <panic>
8010174d:	8d 76 00             	lea    0x0(%esi),%esi

80101750 <iupdate>:
{
80101750:	55                   	push   %ebp
80101751:	89 e5                	mov    %esp,%ebp
80101753:	56                   	push   %esi
80101754:	53                   	push   %ebx
80101755:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101758:	8b 43 04             	mov    0x4(%ebx),%eax
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
8010175b:	83 c3 5c             	add    $0x5c,%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
8010175e:	83 ec 08             	sub    $0x8,%esp
80101761:	c1 e8 03             	shr    $0x3,%eax
80101764:	03 05 28 a6 13 80    	add    0x8013a628,%eax
8010176a:	50                   	push   %eax
8010176b:	ff 73 a4             	push   -0x5c(%ebx)
8010176e:	e8 5d e9 ff ff       	call   801000d0 <bread>
  dip->type = ip->type;
80101773:	0f b7 53 f4          	movzwl -0xc(%ebx),%edx
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80101777:	83 c4 0c             	add    $0xc,%esp
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
8010177a:	89 c6                	mov    %eax,%esi
  dip = (struct dinode*)bp->data + ip->inum%IPB;
8010177c:	8b 43 a8             	mov    -0x58(%ebx),%eax
8010177f:	83 e0 07             	and    $0x7,%eax
80101782:	c1 e0 06             	shl    $0x6,%eax
80101785:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
  dip->type = ip->type;
80101789:	66 89 10             	mov    %dx,(%eax)
  dip->major = ip->major;
8010178c:	0f b7 53 f6          	movzwl -0xa(%ebx),%edx
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80101790:	83 c0 0c             	add    $0xc,%eax
  dip->major = ip->major;
80101793:	66 89 50 f6          	mov    %dx,-0xa(%eax)
  dip->minor = ip->minor;
80101797:	0f b7 53 f8          	movzwl -0x8(%ebx),%edx
8010179b:	66 89 50 f8          	mov    %dx,-0x8(%eax)
  dip->nlink = ip->nlink;
8010179f:	0f b7 53 fa          	movzwl -0x6(%ebx),%edx
801017a3:	66 89 50 fa          	mov    %dx,-0x6(%eax)
  dip->size = ip->size;
801017a7:	8b 53 fc             	mov    -0x4(%ebx),%edx
801017aa:	89 50 fc             	mov    %edx,-0x4(%eax)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
801017ad:	6a 34                	push   $0x34
801017af:	53                   	push   %ebx
801017b0:	50                   	push   %eax
801017b1:	e8 7a 30 00 00       	call   80104830 <memmove>
  log_write(bp);
801017b6:	89 34 24             	mov    %esi,(%esp)
801017b9:	e8 c2 17 00 00       	call   80102f80 <log_write>
  brelse(bp);
801017be:	83 c4 10             	add    $0x10,%esp
801017c1:	89 75 08             	mov    %esi,0x8(%ebp)
}
801017c4:	8d 65 f8             	lea    -0x8(%ebp),%esp
801017c7:	5b                   	pop    %ebx
801017c8:	5e                   	pop    %esi
801017c9:	5d                   	pop    %ebp
  brelse(bp);
801017ca:	e9 21 ea ff ff       	jmp    801001f0 <brelse>
801017cf:	90                   	nop

801017d0 <idup>:
{
801017d0:	55                   	push   %ebp
801017d1:	89 e5                	mov    %esp,%ebp
801017d3:	53                   	push   %ebx
801017d4:	83 ec 10             	sub    $0x10,%esp
801017d7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&icache.lock);
801017da:	68 c0 89 13 80       	push   $0x801389c0
801017df:	e8 bc 2e 00 00       	call   801046a0 <acquire>
  ip->ref++;
801017e4:	83 43 08 01          	addl   $0x1,0x8(%ebx)
  release(&icache.lock);
801017e8:	c7 04 24 c0 89 13 80 	movl   $0x801389c0,(%esp)
801017ef:	e8 4c 2e 00 00       	call   80104640 <release>
}
801017f4:	89 d8                	mov    %ebx,%eax
801017f6:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801017f9:	c9                   	leave
801017fa:	c3                   	ret
801017fb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80101800 <ilock>:
{
80101800:	55                   	push   %ebp
80101801:	89 e5                	mov    %esp,%ebp
80101803:	56                   	push   %esi
80101804:	53                   	push   %ebx
80101805:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || ip->ref < 1)
80101808:	85 db                	test   %ebx,%ebx
8010180a:	0f 84 b7 00 00 00    	je     801018c7 <ilock+0xc7>
80101810:	8b 53 08             	mov    0x8(%ebx),%edx
80101813:	85 d2                	test   %edx,%edx
80101815:	0f 8e ac 00 00 00    	jle    801018c7 <ilock+0xc7>
  acquiresleep(&ip->lock);
8010181b:	83 ec 0c             	sub    $0xc,%esp
8010181e:	8d 43 0c             	lea    0xc(%ebx),%eax
80101821:	50                   	push   %eax
80101822:	e8 99 2b 00 00       	call   801043c0 <acquiresleep>
  if(ip->valid == 0){
80101827:	8b 43 4c             	mov    0x4c(%ebx),%eax
8010182a:	83 c4 10             	add    $0x10,%esp
8010182d:	85 c0                	test   %eax,%eax
8010182f:	74 0f                	je     80101840 <ilock+0x40>
}
80101831:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101834:	5b                   	pop    %ebx
80101835:	5e                   	pop    %esi
80101836:	5d                   	pop    %ebp
80101837:	c3                   	ret
80101838:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010183f:	00 
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101840:	8b 43 04             	mov    0x4(%ebx),%eax
80101843:	83 ec 08             	sub    $0x8,%esp
80101846:	c1 e8 03             	shr    $0x3,%eax
80101849:	03 05 28 a6 13 80    	add    0x8013a628,%eax
8010184f:	50                   	push   %eax
80101850:	ff 33                	push   (%ebx)
80101852:	e8 79 e8 ff ff       	call   801000d0 <bread>
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80101857:	83 c4 0c             	add    $0xc,%esp
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
8010185a:	89 c6                	mov    %eax,%esi
    dip = (struct dinode*)bp->data + ip->inum%IPB;
8010185c:	8b 43 04             	mov    0x4(%ebx),%eax
8010185f:	83 e0 07             	and    $0x7,%eax
80101862:	c1 e0 06             	shl    $0x6,%eax
80101865:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
    ip->type = dip->type;
80101869:	0f b7 10             	movzwl (%eax),%edx
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
8010186c:	83 c0 0c             	add    $0xc,%eax
    ip->type = dip->type;
8010186f:	66 89 53 50          	mov    %dx,0x50(%ebx)
    ip->major = dip->major;
80101873:	0f b7 50 f6          	movzwl -0xa(%eax),%edx
80101877:	66 89 53 52          	mov    %dx,0x52(%ebx)
    ip->minor = dip->minor;
8010187b:	0f b7 50 f8          	movzwl -0x8(%eax),%edx
8010187f:	66 89 53 54          	mov    %dx,0x54(%ebx)
    ip->nlink = dip->nlink;
80101883:	0f b7 50 fa          	movzwl -0x6(%eax),%edx
80101887:	66 89 53 56          	mov    %dx,0x56(%ebx)
    ip->size = dip->size;
8010188b:	8b 50 fc             	mov    -0x4(%eax),%edx
8010188e:	89 53 58             	mov    %edx,0x58(%ebx)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80101891:	6a 34                	push   $0x34
80101893:	50                   	push   %eax
80101894:	8d 43 5c             	lea    0x5c(%ebx),%eax
80101897:	50                   	push   %eax
80101898:	e8 93 2f 00 00       	call   80104830 <memmove>
    brelse(bp);
8010189d:	89 34 24             	mov    %esi,(%esp)
801018a0:	e8 4b e9 ff ff       	call   801001f0 <brelse>
    if(ip->type == 0)
801018a5:	83 c4 10             	add    $0x10,%esp
801018a8:	66 83 7b 50 00       	cmpw   $0x0,0x50(%ebx)
    ip->valid = 1;
801018ad:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
    if(ip->type == 0)
801018b4:	0f 85 77 ff ff ff    	jne    80101831 <ilock+0x31>
      panic("ilock: no type");
801018ba:	83 ec 0c             	sub    $0xc,%esp
801018bd:	68 7f 83 10 80       	push   $0x8010837f
801018c2:	e8 b9 ea ff ff       	call   80100380 <panic>
    panic("ilock");
801018c7:	83 ec 0c             	sub    $0xc,%esp
801018ca:	68 79 83 10 80       	push   $0x80108379
801018cf:	e8 ac ea ff ff       	call   80100380 <panic>
801018d4:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801018db:	00 
801018dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801018e0 <iunlock>:
{
801018e0:	55                   	push   %ebp
801018e1:	89 e5                	mov    %esp,%ebp
801018e3:	56                   	push   %esi
801018e4:	53                   	push   %ebx
801018e5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
801018e8:	85 db                	test   %ebx,%ebx
801018ea:	74 28                	je     80101914 <iunlock+0x34>
801018ec:	83 ec 0c             	sub    $0xc,%esp
801018ef:	8d 73 0c             	lea    0xc(%ebx),%esi
801018f2:	56                   	push   %esi
801018f3:	e8 68 2b 00 00       	call   80104460 <holdingsleep>
801018f8:	83 c4 10             	add    $0x10,%esp
801018fb:	85 c0                	test   %eax,%eax
801018fd:	74 15                	je     80101914 <iunlock+0x34>
801018ff:	8b 43 08             	mov    0x8(%ebx),%eax
80101902:	85 c0                	test   %eax,%eax
80101904:	7e 0e                	jle    80101914 <iunlock+0x34>
  releasesleep(&ip->lock);
80101906:	89 75 08             	mov    %esi,0x8(%ebp)
}
80101909:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010190c:	5b                   	pop    %ebx
8010190d:	5e                   	pop    %esi
8010190e:	5d                   	pop    %ebp
  releasesleep(&ip->lock);
8010190f:	e9 0c 2b 00 00       	jmp    80104420 <releasesleep>
    panic("iunlock");
80101914:	83 ec 0c             	sub    $0xc,%esp
80101917:	68 8e 83 10 80       	push   $0x8010838e
8010191c:	e8 5f ea ff ff       	call   80100380 <panic>
80101921:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80101928:	00 
80101929:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101930 <iput>:
{
80101930:	55                   	push   %ebp
80101931:	89 e5                	mov    %esp,%ebp
80101933:	57                   	push   %edi
80101934:	56                   	push   %esi
80101935:	53                   	push   %ebx
80101936:	83 ec 28             	sub    $0x28,%esp
80101939:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquiresleep(&ip->lock);
8010193c:	8d 7b 0c             	lea    0xc(%ebx),%edi
8010193f:	57                   	push   %edi
80101940:	e8 7b 2a 00 00       	call   801043c0 <acquiresleep>
  if(ip->valid && ip->nlink == 0){
80101945:	8b 53 4c             	mov    0x4c(%ebx),%edx
80101948:	83 c4 10             	add    $0x10,%esp
8010194b:	85 d2                	test   %edx,%edx
8010194d:	74 07                	je     80101956 <iput+0x26>
8010194f:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
80101954:	74 32                	je     80101988 <iput+0x58>
  releasesleep(&ip->lock);
80101956:	83 ec 0c             	sub    $0xc,%esp
80101959:	57                   	push   %edi
8010195a:	e8 c1 2a 00 00       	call   80104420 <releasesleep>
  acquire(&icache.lock);
8010195f:	c7 04 24 c0 89 13 80 	movl   $0x801389c0,(%esp)
80101966:	e8 35 2d 00 00       	call   801046a0 <acquire>
  ip->ref--;
8010196b:	83 6b 08 01          	subl   $0x1,0x8(%ebx)
  release(&icache.lock);
8010196f:	83 c4 10             	add    $0x10,%esp
80101972:	c7 45 08 c0 89 13 80 	movl   $0x801389c0,0x8(%ebp)
}
80101979:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010197c:	5b                   	pop    %ebx
8010197d:	5e                   	pop    %esi
8010197e:	5f                   	pop    %edi
8010197f:	5d                   	pop    %ebp
  release(&icache.lock);
80101980:	e9 bb 2c 00 00       	jmp    80104640 <release>
80101985:	8d 76 00             	lea    0x0(%esi),%esi
    acquire(&icache.lock);
80101988:	83 ec 0c             	sub    $0xc,%esp
8010198b:	68 c0 89 13 80       	push   $0x801389c0
80101990:	e8 0b 2d 00 00       	call   801046a0 <acquire>
    int r = ip->ref;
80101995:	8b 73 08             	mov    0x8(%ebx),%esi
    release(&icache.lock);
80101998:	c7 04 24 c0 89 13 80 	movl   $0x801389c0,(%esp)
8010199f:	e8 9c 2c 00 00       	call   80104640 <release>
    if(r == 1){
801019a4:	83 c4 10             	add    $0x10,%esp
801019a7:	83 fe 01             	cmp    $0x1,%esi
801019aa:	75 aa                	jne    80101956 <iput+0x26>
801019ac:	8d 8b 8c 00 00 00    	lea    0x8c(%ebx),%ecx
801019b2:	89 7d e4             	mov    %edi,-0x1c(%ebp)
801019b5:	8d 73 5c             	lea    0x5c(%ebx),%esi
801019b8:	89 df                	mov    %ebx,%edi
801019ba:	89 cb                	mov    %ecx,%ebx
801019bc:	eb 09                	jmp    801019c7 <iput+0x97>
801019be:	66 90                	xchg   %ax,%ax
{
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
801019c0:	83 c6 04             	add    $0x4,%esi
801019c3:	39 de                	cmp    %ebx,%esi
801019c5:	74 19                	je     801019e0 <iput+0xb0>
    if(ip->addrs[i]){
801019c7:	8b 16                	mov    (%esi),%edx
801019c9:	85 d2                	test   %edx,%edx
801019cb:	74 f3                	je     801019c0 <iput+0x90>
      bfree(ip->dev, ip->addrs[i]);
801019cd:	8b 07                	mov    (%edi),%eax
801019cf:	e8 7c fa ff ff       	call   80101450 <bfree>
      ip->addrs[i] = 0;
801019d4:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
801019da:	eb e4                	jmp    801019c0 <iput+0x90>
801019dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    }
  }

  if(ip->addrs[NDIRECT]){
801019e0:	89 fb                	mov    %edi,%ebx
801019e2:	8b 7d e4             	mov    -0x1c(%ebp),%edi
801019e5:	8b 83 8c 00 00 00    	mov    0x8c(%ebx),%eax
801019eb:	85 c0                	test   %eax,%eax
801019ed:	75 2d                	jne    80101a1c <iput+0xec>
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
  iupdate(ip);
801019ef:	83 ec 0c             	sub    $0xc,%esp
  ip->size = 0;
801019f2:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  iupdate(ip);
801019f9:	53                   	push   %ebx
801019fa:	e8 51 fd ff ff       	call   80101750 <iupdate>
      ip->type = 0;
801019ff:	31 c0                	xor    %eax,%eax
80101a01:	66 89 43 50          	mov    %ax,0x50(%ebx)
      iupdate(ip);
80101a05:	89 1c 24             	mov    %ebx,(%esp)
80101a08:	e8 43 fd ff ff       	call   80101750 <iupdate>
      ip->valid = 0;
80101a0d:	c7 43 4c 00 00 00 00 	movl   $0x0,0x4c(%ebx)
80101a14:	83 c4 10             	add    $0x10,%esp
80101a17:	e9 3a ff ff ff       	jmp    80101956 <iput+0x26>
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
80101a1c:	83 ec 08             	sub    $0x8,%esp
80101a1f:	50                   	push   %eax
80101a20:	ff 33                	push   (%ebx)
80101a22:	e8 a9 e6 ff ff       	call   801000d0 <bread>
    for(j = 0; j < NINDIRECT; j++){
80101a27:	83 c4 10             	add    $0x10,%esp
80101a2a:	89 7d e4             	mov    %edi,-0x1c(%ebp)
80101a2d:	8d 88 5c 02 00 00    	lea    0x25c(%eax),%ecx
80101a33:	89 45 e0             	mov    %eax,-0x20(%ebp)
80101a36:	8d 70 5c             	lea    0x5c(%eax),%esi
80101a39:	89 cf                	mov    %ecx,%edi
80101a3b:	eb 0a                	jmp    80101a47 <iput+0x117>
80101a3d:	8d 76 00             	lea    0x0(%esi),%esi
80101a40:	83 c6 04             	add    $0x4,%esi
80101a43:	39 fe                	cmp    %edi,%esi
80101a45:	74 0f                	je     80101a56 <iput+0x126>
      if(a[j])
80101a47:	8b 16                	mov    (%esi),%edx
80101a49:	85 d2                	test   %edx,%edx
80101a4b:	74 f3                	je     80101a40 <iput+0x110>
        bfree(ip->dev, a[j]);
80101a4d:	8b 03                	mov    (%ebx),%eax
80101a4f:	e8 fc f9 ff ff       	call   80101450 <bfree>
80101a54:	eb ea                	jmp    80101a40 <iput+0x110>
    brelse(bp);
80101a56:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101a59:	83 ec 0c             	sub    $0xc,%esp
80101a5c:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80101a5f:	50                   	push   %eax
80101a60:	e8 8b e7 ff ff       	call   801001f0 <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
80101a65:	8b 93 8c 00 00 00    	mov    0x8c(%ebx),%edx
80101a6b:	8b 03                	mov    (%ebx),%eax
80101a6d:	e8 de f9 ff ff       	call   80101450 <bfree>
    ip->addrs[NDIRECT] = 0;
80101a72:	83 c4 10             	add    $0x10,%esp
80101a75:	c7 83 8c 00 00 00 00 	movl   $0x0,0x8c(%ebx)
80101a7c:	00 00 00 
80101a7f:	e9 6b ff ff ff       	jmp    801019ef <iput+0xbf>
80101a84:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80101a8b:	00 
80101a8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101a90 <iunlockput>:
{
80101a90:	55                   	push   %ebp
80101a91:	89 e5                	mov    %esp,%ebp
80101a93:	56                   	push   %esi
80101a94:	53                   	push   %ebx
80101a95:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80101a98:	85 db                	test   %ebx,%ebx
80101a9a:	74 34                	je     80101ad0 <iunlockput+0x40>
80101a9c:	83 ec 0c             	sub    $0xc,%esp
80101a9f:	8d 73 0c             	lea    0xc(%ebx),%esi
80101aa2:	56                   	push   %esi
80101aa3:	e8 b8 29 00 00       	call   80104460 <holdingsleep>
80101aa8:	83 c4 10             	add    $0x10,%esp
80101aab:	85 c0                	test   %eax,%eax
80101aad:	74 21                	je     80101ad0 <iunlockput+0x40>
80101aaf:	8b 43 08             	mov    0x8(%ebx),%eax
80101ab2:	85 c0                	test   %eax,%eax
80101ab4:	7e 1a                	jle    80101ad0 <iunlockput+0x40>
  releasesleep(&ip->lock);
80101ab6:	83 ec 0c             	sub    $0xc,%esp
80101ab9:	56                   	push   %esi
80101aba:	e8 61 29 00 00       	call   80104420 <releasesleep>
  iput(ip);
80101abf:	83 c4 10             	add    $0x10,%esp
80101ac2:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
80101ac5:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101ac8:	5b                   	pop    %ebx
80101ac9:	5e                   	pop    %esi
80101aca:	5d                   	pop    %ebp
  iput(ip);
80101acb:	e9 60 fe ff ff       	jmp    80101930 <iput>
    panic("iunlock");
80101ad0:	83 ec 0c             	sub    $0xc,%esp
80101ad3:	68 8e 83 10 80       	push   $0x8010838e
80101ad8:	e8 a3 e8 ff ff       	call   80100380 <panic>
80101add:	8d 76 00             	lea    0x0(%esi),%esi

80101ae0 <stati>:

// Copy stat information from inode.
// Caller must hold ip->lock.
void
stati(struct inode *ip, struct stat *st)
{
80101ae0:	55                   	push   %ebp
80101ae1:	89 e5                	mov    %esp,%ebp
80101ae3:	8b 55 08             	mov    0x8(%ebp),%edx
80101ae6:	8b 45 0c             	mov    0xc(%ebp),%eax
  st->dev = ip->dev;
80101ae9:	8b 0a                	mov    (%edx),%ecx
80101aeb:	89 48 04             	mov    %ecx,0x4(%eax)
  st->ino = ip->inum;
80101aee:	8b 4a 04             	mov    0x4(%edx),%ecx
80101af1:	89 48 08             	mov    %ecx,0x8(%eax)
  st->type = ip->type;
80101af4:	0f b7 4a 50          	movzwl 0x50(%edx),%ecx
80101af8:	66 89 08             	mov    %cx,(%eax)
  st->nlink = ip->nlink;
80101afb:	0f b7 4a 56          	movzwl 0x56(%edx),%ecx
80101aff:	66 89 48 0c          	mov    %cx,0xc(%eax)
  st->size = ip->size;
80101b03:	8b 52 58             	mov    0x58(%edx),%edx
80101b06:	89 50 10             	mov    %edx,0x10(%eax)
}
80101b09:	5d                   	pop    %ebp
80101b0a:	c3                   	ret
80101b0b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80101b10 <readi>:
//PAGEBREAK!
// Read data from inode.
// Caller must hold ip->lock.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
80101b10:	55                   	push   %ebp
80101b11:	89 e5                	mov    %esp,%ebp
80101b13:	57                   	push   %edi
80101b14:	56                   	push   %esi
80101b15:	53                   	push   %ebx
80101b16:	83 ec 1c             	sub    $0x1c,%esp
80101b19:	8b 75 08             	mov    0x8(%ebp),%esi
80101b1c:	8b 45 0c             	mov    0xc(%ebp),%eax
80101b1f:	8b 7d 10             	mov    0x10(%ebp),%edi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101b22:	66 83 7e 50 03       	cmpw   $0x3,0x50(%esi)
{
80101b27:	89 45 e0             	mov    %eax,-0x20(%ebp)
80101b2a:	89 75 d8             	mov    %esi,-0x28(%ebp)
80101b2d:	8b 45 14             	mov    0x14(%ebp),%eax
  if(ip->type == T_DEV){
80101b30:	0f 84 aa 00 00 00    	je     80101be0 <readi+0xd0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
  }

  if(off > ip->size || off + n < off)
80101b36:	8b 75 d8             	mov    -0x28(%ebp),%esi
80101b39:	8b 56 58             	mov    0x58(%esi),%edx
80101b3c:	39 fa                	cmp    %edi,%edx
80101b3e:	0f 82 bd 00 00 00    	jb     80101c01 <readi+0xf1>
80101b44:	89 f9                	mov    %edi,%ecx
80101b46:	31 db                	xor    %ebx,%ebx
80101b48:	01 c1                	add    %eax,%ecx
80101b4a:	0f 92 c3             	setb   %bl
80101b4d:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
80101b50:	0f 82 ab 00 00 00    	jb     80101c01 <readi+0xf1>
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;
80101b56:	89 d3                	mov    %edx,%ebx
80101b58:	29 fb                	sub    %edi,%ebx
80101b5a:	39 ca                	cmp    %ecx,%edx
80101b5c:	0f 42 c3             	cmovb  %ebx,%eax

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101b5f:	85 c0                	test   %eax,%eax
80101b61:	74 73                	je     80101bd6 <readi+0xc6>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
80101b63:	8b 75 e4             	mov    -0x1c(%ebp),%esi
80101b66:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80101b69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101b70:	8b 5d d8             	mov    -0x28(%ebp),%ebx
80101b73:	89 fa                	mov    %edi,%edx
80101b75:	c1 ea 09             	shr    $0x9,%edx
80101b78:	89 d8                	mov    %ebx,%eax
80101b7a:	e8 51 f9 ff ff       	call   801014d0 <bmap>
80101b7f:	83 ec 08             	sub    $0x8,%esp
80101b82:	50                   	push   %eax
80101b83:	ff 33                	push   (%ebx)
80101b85:	e8 46 e5 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
80101b8a:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80101b8d:	b9 00 02 00 00       	mov    $0x200,%ecx
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101b92:	89 c2                	mov    %eax,%edx
    m = min(n - tot, BSIZE - off%BSIZE);
80101b94:	89 f8                	mov    %edi,%eax
80101b96:	25 ff 01 00 00       	and    $0x1ff,%eax
80101b9b:	29 f3                	sub    %esi,%ebx
80101b9d:	29 c1                	sub    %eax,%ecx
    memmove(dst, bp->data + off%BSIZE, m);
80101b9f:	8d 44 02 5c          	lea    0x5c(%edx,%eax,1),%eax
    m = min(n - tot, BSIZE - off%BSIZE);
80101ba3:	39 d9                	cmp    %ebx,%ecx
80101ba5:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(dst, bp->data + off%BSIZE, m);
80101ba8:	83 c4 0c             	add    $0xc,%esp
80101bab:	53                   	push   %ebx
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101bac:	01 de                	add    %ebx,%esi
80101bae:	01 df                	add    %ebx,%edi
    memmove(dst, bp->data + off%BSIZE, m);
80101bb0:	89 55 dc             	mov    %edx,-0x24(%ebp)
80101bb3:	50                   	push   %eax
80101bb4:	ff 75 e0             	push   -0x20(%ebp)
80101bb7:	e8 74 2c 00 00       	call   80104830 <memmove>
    brelse(bp);
80101bbc:	8b 55 dc             	mov    -0x24(%ebp),%edx
80101bbf:	89 14 24             	mov    %edx,(%esp)
80101bc2:	e8 29 e6 ff ff       	call   801001f0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101bc7:	01 5d e0             	add    %ebx,-0x20(%ebp)
80101bca:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80101bcd:	83 c4 10             	add    $0x10,%esp
80101bd0:	39 de                	cmp    %ebx,%esi
80101bd2:	72 9c                	jb     80101b70 <readi+0x60>
80101bd4:	89 d8                	mov    %ebx,%eax
  }
  return n;
}
80101bd6:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101bd9:	5b                   	pop    %ebx
80101bda:	5e                   	pop    %esi
80101bdb:	5f                   	pop    %edi
80101bdc:	5d                   	pop    %ebp
80101bdd:	c3                   	ret
80101bde:	66 90                	xchg   %ax,%ax
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
80101be0:	0f bf 56 52          	movswl 0x52(%esi),%edx
80101be4:	66 83 fa 09          	cmp    $0x9,%dx
80101be8:	77 17                	ja     80101c01 <readi+0xf1>
80101bea:	8b 14 d5 60 89 13 80 	mov    -0x7fec76a0(,%edx,8),%edx
80101bf1:	85 d2                	test   %edx,%edx
80101bf3:	74 0c                	je     80101c01 <readi+0xf1>
    return devsw[ip->major].read(ip, dst, n);
80101bf5:	89 45 10             	mov    %eax,0x10(%ebp)
}
80101bf8:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101bfb:	5b                   	pop    %ebx
80101bfc:	5e                   	pop    %esi
80101bfd:	5f                   	pop    %edi
80101bfe:	5d                   	pop    %ebp
    return devsw[ip->major].read(ip, dst, n);
80101bff:	ff e2                	jmp    *%edx
      return -1;
80101c01:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101c06:	eb ce                	jmp    80101bd6 <readi+0xc6>
80101c08:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80101c0f:	00 

80101c10 <writei>:
// PAGEBREAK!
// Write data to inode.
// Caller must hold ip->lock.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
80101c10:	55                   	push   %ebp
80101c11:	89 e5                	mov    %esp,%ebp
80101c13:	57                   	push   %edi
80101c14:	56                   	push   %esi
80101c15:	53                   	push   %ebx
80101c16:	83 ec 1c             	sub    $0x1c,%esp
80101c19:	8b 45 08             	mov    0x8(%ebp),%eax
80101c1c:	8b 7d 0c             	mov    0xc(%ebp),%edi
80101c1f:	8b 75 14             	mov    0x14(%ebp),%esi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101c22:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
{
80101c27:	89 7d dc             	mov    %edi,-0x24(%ebp)
80101c2a:	89 75 e0             	mov    %esi,-0x20(%ebp)
80101c2d:	8b 7d 10             	mov    0x10(%ebp),%edi
  if(ip->type == T_DEV){
80101c30:	0f 84 ba 00 00 00    	je     80101cf0 <writei+0xe0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
  }

  if(off > ip->size || off + n < off)
80101c36:	39 78 58             	cmp    %edi,0x58(%eax)
80101c39:	0f 82 ea 00 00 00    	jb     80101d29 <writei+0x119>
    return -1;
  if(off + n > MAXFILE*BSIZE)
80101c3f:	8b 75 e0             	mov    -0x20(%ebp),%esi
80101c42:	89 f2                	mov    %esi,%edx
80101c44:	01 fa                	add    %edi,%edx
80101c46:	0f 82 dd 00 00 00    	jb     80101d29 <writei+0x119>
80101c4c:	81 fa 00 18 01 00    	cmp    $0x11800,%edx
80101c52:	0f 87 d1 00 00 00    	ja     80101d29 <writei+0x119>
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101c58:	85 f6                	test   %esi,%esi
80101c5a:	0f 84 85 00 00 00    	je     80101ce5 <writei+0xd5>
80101c60:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
80101c67:	89 45 d8             	mov    %eax,-0x28(%ebp)
80101c6a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101c70:	8b 75 d8             	mov    -0x28(%ebp),%esi
80101c73:	89 fa                	mov    %edi,%edx
80101c75:	c1 ea 09             	shr    $0x9,%edx
80101c78:	89 f0                	mov    %esi,%eax
80101c7a:	e8 51 f8 ff ff       	call   801014d0 <bmap>
80101c7f:	83 ec 08             	sub    $0x8,%esp
80101c82:	50                   	push   %eax
80101c83:	ff 36                	push   (%esi)
80101c85:	e8 46 e4 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
80101c8a:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101c8d:	8b 5d e0             	mov    -0x20(%ebp),%ebx
80101c90:	b9 00 02 00 00       	mov    $0x200,%ecx
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101c95:	89 c6                	mov    %eax,%esi
    m = min(n - tot, BSIZE - off%BSIZE);
80101c97:	89 f8                	mov    %edi,%eax
80101c99:	25 ff 01 00 00       	and    $0x1ff,%eax
80101c9e:	29 d3                	sub    %edx,%ebx
80101ca0:	29 c1                	sub    %eax,%ecx
    memmove(bp->data + off%BSIZE, src, m);
80101ca2:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
    m = min(n - tot, BSIZE - off%BSIZE);
80101ca6:	39 d9                	cmp    %ebx,%ecx
80101ca8:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(bp->data + off%BSIZE, src, m);
80101cab:	83 c4 0c             	add    $0xc,%esp
80101cae:	53                   	push   %ebx
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101caf:	01 df                	add    %ebx,%edi
    memmove(bp->data + off%BSIZE, src, m);
80101cb1:	ff 75 dc             	push   -0x24(%ebp)
80101cb4:	50                   	push   %eax
80101cb5:	e8 76 2b 00 00       	call   80104830 <memmove>
    log_write(bp);
80101cba:	89 34 24             	mov    %esi,(%esp)
80101cbd:	e8 be 12 00 00       	call   80102f80 <log_write>
    brelse(bp);
80101cc2:	89 34 24             	mov    %esi,(%esp)
80101cc5:	e8 26 e5 ff ff       	call   801001f0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101cca:	01 5d e4             	add    %ebx,-0x1c(%ebp)
80101ccd:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101cd0:	83 c4 10             	add    $0x10,%esp
80101cd3:	01 5d dc             	add    %ebx,-0x24(%ebp)
80101cd6:	8b 5d e0             	mov    -0x20(%ebp),%ebx
80101cd9:	39 d8                	cmp    %ebx,%eax
80101cdb:	72 93                	jb     80101c70 <writei+0x60>
  }

  if(n > 0 && off > ip->size){
80101cdd:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101ce0:	39 78 58             	cmp    %edi,0x58(%eax)
80101ce3:	72 33                	jb     80101d18 <writei+0x108>
    ip->size = off;
    iupdate(ip);
  }
  return n;
80101ce5:	8b 45 e0             	mov    -0x20(%ebp),%eax
}
80101ce8:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101ceb:	5b                   	pop    %ebx
80101cec:	5e                   	pop    %esi
80101ced:	5f                   	pop    %edi
80101cee:	5d                   	pop    %ebp
80101cef:	c3                   	ret
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
80101cf0:	0f bf 40 52          	movswl 0x52(%eax),%eax
80101cf4:	66 83 f8 09          	cmp    $0x9,%ax
80101cf8:	77 2f                	ja     80101d29 <writei+0x119>
80101cfa:	8b 04 c5 64 89 13 80 	mov    -0x7fec769c(,%eax,8),%eax
80101d01:	85 c0                	test   %eax,%eax
80101d03:	74 24                	je     80101d29 <writei+0x119>
    return devsw[ip->major].write(ip, src, n);
80101d05:	89 75 10             	mov    %esi,0x10(%ebp)
}
80101d08:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101d0b:	5b                   	pop    %ebx
80101d0c:	5e                   	pop    %esi
80101d0d:	5f                   	pop    %edi
80101d0e:	5d                   	pop    %ebp
    return devsw[ip->major].write(ip, src, n);
80101d0f:	ff e0                	jmp    *%eax
80101d11:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    iupdate(ip);
80101d18:	83 ec 0c             	sub    $0xc,%esp
    ip->size = off;
80101d1b:	89 78 58             	mov    %edi,0x58(%eax)
    iupdate(ip);
80101d1e:	50                   	push   %eax
80101d1f:	e8 2c fa ff ff       	call   80101750 <iupdate>
80101d24:	83 c4 10             	add    $0x10,%esp
80101d27:	eb bc                	jmp    80101ce5 <writei+0xd5>
      return -1;
80101d29:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101d2e:	eb b8                	jmp    80101ce8 <writei+0xd8>

80101d30 <namecmp>:
//PAGEBREAK!
// Directories

int
namecmp(const char *s, const char *t)
{
80101d30:	55                   	push   %ebp
80101d31:	89 e5                	mov    %esp,%ebp
80101d33:	83 ec 0c             	sub    $0xc,%esp
  return strncmp(s, t, DIRSIZ);
80101d36:	6a 0e                	push   $0xe
80101d38:	ff 75 0c             	push   0xc(%ebp)
80101d3b:	ff 75 08             	push   0x8(%ebp)
80101d3e:	e8 5d 2b 00 00       	call   801048a0 <strncmp>
}
80101d43:	c9                   	leave
80101d44:	c3                   	ret
80101d45:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80101d4c:	00 
80101d4d:	8d 76 00             	lea    0x0(%esi),%esi

80101d50 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
80101d50:	55                   	push   %ebp
80101d51:	89 e5                	mov    %esp,%ebp
80101d53:	57                   	push   %edi
80101d54:	56                   	push   %esi
80101d55:	53                   	push   %ebx
80101d56:	83 ec 1c             	sub    $0x1c,%esp
80101d59:	8b 5d 08             	mov    0x8(%ebp),%ebx
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
80101d5c:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80101d61:	0f 85 85 00 00 00    	jne    80101dec <dirlookup+0x9c>
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
80101d67:	8b 53 58             	mov    0x58(%ebx),%edx
80101d6a:	31 ff                	xor    %edi,%edi
80101d6c:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101d6f:	85 d2                	test   %edx,%edx
80101d71:	74 3e                	je     80101db1 <dirlookup+0x61>
80101d73:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101d78:	6a 10                	push   $0x10
80101d7a:	57                   	push   %edi
80101d7b:	56                   	push   %esi
80101d7c:	53                   	push   %ebx
80101d7d:	e8 8e fd ff ff       	call   80101b10 <readi>
80101d82:	83 c4 10             	add    $0x10,%esp
80101d85:	83 f8 10             	cmp    $0x10,%eax
80101d88:	75 55                	jne    80101ddf <dirlookup+0x8f>
      panic("dirlookup read");
    if(de.inum == 0)
80101d8a:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80101d8f:	74 18                	je     80101da9 <dirlookup+0x59>
  return strncmp(s, t, DIRSIZ);
80101d91:	83 ec 04             	sub    $0x4,%esp
80101d94:	8d 45 da             	lea    -0x26(%ebp),%eax
80101d97:	6a 0e                	push   $0xe
80101d99:	50                   	push   %eax
80101d9a:	ff 75 0c             	push   0xc(%ebp)
80101d9d:	e8 fe 2a 00 00       	call   801048a0 <strncmp>
      continue;
    if(namecmp(name, de.name) == 0){
80101da2:	83 c4 10             	add    $0x10,%esp
80101da5:	85 c0                	test   %eax,%eax
80101da7:	74 17                	je     80101dc0 <dirlookup+0x70>
  for(off = 0; off < dp->size; off += sizeof(de)){
80101da9:	83 c7 10             	add    $0x10,%edi
80101dac:	3b 7b 58             	cmp    0x58(%ebx),%edi
80101daf:	72 c7                	jb     80101d78 <dirlookup+0x28>
      return iget(dp->dev, inum);
    }
  }

  return 0;
}
80101db1:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80101db4:	31 c0                	xor    %eax,%eax
}
80101db6:	5b                   	pop    %ebx
80101db7:	5e                   	pop    %esi
80101db8:	5f                   	pop    %edi
80101db9:	5d                   	pop    %ebp
80101dba:	c3                   	ret
80101dbb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
      if(poff)
80101dc0:	8b 45 10             	mov    0x10(%ebp),%eax
80101dc3:	85 c0                	test   %eax,%eax
80101dc5:	74 05                	je     80101dcc <dirlookup+0x7c>
        *poff = off;
80101dc7:	8b 45 10             	mov    0x10(%ebp),%eax
80101dca:	89 38                	mov    %edi,(%eax)
      inum = de.inum;
80101dcc:	0f b7 55 d8          	movzwl -0x28(%ebp),%edx
      return iget(dp->dev, inum);
80101dd0:	8b 03                	mov    (%ebx),%eax
80101dd2:	e8 79 f5 ff ff       	call   80101350 <iget>
}
80101dd7:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101dda:	5b                   	pop    %ebx
80101ddb:	5e                   	pop    %esi
80101ddc:	5f                   	pop    %edi
80101ddd:	5d                   	pop    %ebp
80101dde:	c3                   	ret
      panic("dirlookup read");
80101ddf:	83 ec 0c             	sub    $0xc,%esp
80101de2:	68 a8 83 10 80       	push   $0x801083a8
80101de7:	e8 94 e5 ff ff       	call   80100380 <panic>
    panic("dirlookup not DIR");
80101dec:	83 ec 0c             	sub    $0xc,%esp
80101def:	68 96 83 10 80       	push   $0x80108396
80101df4:	e8 87 e5 ff ff       	call   80100380 <panic>
80101df9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101e00 <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
80101e00:	55                   	push   %ebp
80101e01:	89 e5                	mov    %esp,%ebp
80101e03:	57                   	push   %edi
80101e04:	56                   	push   %esi
80101e05:	53                   	push   %ebx
80101e06:	89 c3                	mov    %eax,%ebx
80101e08:	83 ec 1c             	sub    $0x1c,%esp
  struct inode *ip, *next;

  if(*path == '/')
80101e0b:	80 38 2f             	cmpb   $0x2f,(%eax)
{
80101e0e:	89 55 dc             	mov    %edx,-0x24(%ebp)
80101e11:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
  if(*path == '/')
80101e14:	0f 84 9e 01 00 00    	je     80101fb8 <namex+0x1b8>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);
80101e1a:	e8 b1 1b 00 00       	call   801039d0 <myproc>
  acquire(&icache.lock);
80101e1f:	83 ec 0c             	sub    $0xc,%esp
    ip = idup(myproc()->cwd);
80101e22:	8b 70 68             	mov    0x68(%eax),%esi
  acquire(&icache.lock);
80101e25:	68 c0 89 13 80       	push   $0x801389c0
80101e2a:	e8 71 28 00 00       	call   801046a0 <acquire>
  ip->ref++;
80101e2f:	83 46 08 01          	addl   $0x1,0x8(%esi)
  release(&icache.lock);
80101e33:	c7 04 24 c0 89 13 80 	movl   $0x801389c0,(%esp)
80101e3a:	e8 01 28 00 00       	call   80104640 <release>
80101e3f:	83 c4 10             	add    $0x10,%esp
80101e42:	eb 07                	jmp    80101e4b <namex+0x4b>
80101e44:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    path++;
80101e48:	83 c3 01             	add    $0x1,%ebx
  while(*path == '/')
80101e4b:	0f b6 03             	movzbl (%ebx),%eax
80101e4e:	3c 2f                	cmp    $0x2f,%al
80101e50:	74 f6                	je     80101e48 <namex+0x48>
  if(*path == 0)
80101e52:	84 c0                	test   %al,%al
80101e54:	0f 84 06 01 00 00    	je     80101f60 <namex+0x160>
  while(*path != '/' && *path != 0)
80101e5a:	0f b6 03             	movzbl (%ebx),%eax
80101e5d:	84 c0                	test   %al,%al
80101e5f:	0f 84 10 01 00 00    	je     80101f75 <namex+0x175>
80101e65:	89 df                	mov    %ebx,%edi
80101e67:	3c 2f                	cmp    $0x2f,%al
80101e69:	0f 84 06 01 00 00    	je     80101f75 <namex+0x175>
80101e6f:	90                   	nop
80101e70:	0f b6 47 01          	movzbl 0x1(%edi),%eax
    path++;
80101e74:	83 c7 01             	add    $0x1,%edi
  while(*path != '/' && *path != 0)
80101e77:	3c 2f                	cmp    $0x2f,%al
80101e79:	74 04                	je     80101e7f <namex+0x7f>
80101e7b:	84 c0                	test   %al,%al
80101e7d:	75 f1                	jne    80101e70 <namex+0x70>
  len = path - s;
80101e7f:	89 f8                	mov    %edi,%eax
80101e81:	29 d8                	sub    %ebx,%eax
  if(len >= DIRSIZ)
80101e83:	83 f8 0d             	cmp    $0xd,%eax
80101e86:	0f 8e ac 00 00 00    	jle    80101f38 <namex+0x138>
    memmove(name, s, DIRSIZ);
80101e8c:	83 ec 04             	sub    $0x4,%esp
80101e8f:	6a 0e                	push   $0xe
80101e91:	53                   	push   %ebx
80101e92:	89 fb                	mov    %edi,%ebx
80101e94:	ff 75 e4             	push   -0x1c(%ebp)
80101e97:	e8 94 29 00 00       	call   80104830 <memmove>
80101e9c:	83 c4 10             	add    $0x10,%esp
  while(*path == '/')
80101e9f:	80 3f 2f             	cmpb   $0x2f,(%edi)
80101ea2:	75 0c                	jne    80101eb0 <namex+0xb0>
80101ea4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    path++;
80101ea8:	83 c3 01             	add    $0x1,%ebx
  while(*path == '/')
80101eab:	80 3b 2f             	cmpb   $0x2f,(%ebx)
80101eae:	74 f8                	je     80101ea8 <namex+0xa8>

  while((path = skipelem(path, name)) != 0){
    ilock(ip);
80101eb0:	83 ec 0c             	sub    $0xc,%esp
80101eb3:	56                   	push   %esi
80101eb4:	e8 47 f9 ff ff       	call   80101800 <ilock>
    if(ip->type != T_DIR){
80101eb9:	83 c4 10             	add    $0x10,%esp
80101ebc:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80101ec1:	0f 85 b7 00 00 00    	jne    80101f7e <namex+0x17e>
      iunlockput(ip);
      return 0;
    }
    if(nameiparent && *path == '\0'){
80101ec7:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101eca:	85 c0                	test   %eax,%eax
80101ecc:	74 09                	je     80101ed7 <namex+0xd7>
80101ece:	80 3b 00             	cmpb   $0x0,(%ebx)
80101ed1:	0f 84 f7 00 00 00    	je     80101fce <namex+0x1ce>
      // Stop one level early.
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
80101ed7:	83 ec 04             	sub    $0x4,%esp
80101eda:	6a 00                	push   $0x0
80101edc:	ff 75 e4             	push   -0x1c(%ebp)
80101edf:	56                   	push   %esi
80101ee0:	e8 6b fe ff ff       	call   80101d50 <dirlookup>
80101ee5:	83 c4 10             	add    $0x10,%esp
80101ee8:	89 c7                	mov    %eax,%edi
80101eea:	85 c0                	test   %eax,%eax
80101eec:	0f 84 8c 00 00 00    	je     80101f7e <namex+0x17e>
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80101ef2:	83 ec 0c             	sub    $0xc,%esp
80101ef5:	8d 4e 0c             	lea    0xc(%esi),%ecx
80101ef8:	51                   	push   %ecx
80101ef9:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80101efc:	e8 5f 25 00 00       	call   80104460 <holdingsleep>
80101f01:	83 c4 10             	add    $0x10,%esp
80101f04:	85 c0                	test   %eax,%eax
80101f06:	0f 84 02 01 00 00    	je     8010200e <namex+0x20e>
80101f0c:	8b 56 08             	mov    0x8(%esi),%edx
80101f0f:	85 d2                	test   %edx,%edx
80101f11:	0f 8e f7 00 00 00    	jle    8010200e <namex+0x20e>
  releasesleep(&ip->lock);
80101f17:	8b 4d e0             	mov    -0x20(%ebp),%ecx
80101f1a:	83 ec 0c             	sub    $0xc,%esp
80101f1d:	51                   	push   %ecx
80101f1e:	e8 fd 24 00 00       	call   80104420 <releasesleep>
  iput(ip);
80101f23:	89 34 24             	mov    %esi,(%esp)
      iunlockput(ip);
      return 0;
    }
    iunlockput(ip);
    ip = next;
80101f26:	89 fe                	mov    %edi,%esi
  iput(ip);
80101f28:	e8 03 fa ff ff       	call   80101930 <iput>
80101f2d:	83 c4 10             	add    $0x10,%esp
  while(*path == '/')
80101f30:	e9 16 ff ff ff       	jmp    80101e4b <namex+0x4b>
80101f35:	8d 76 00             	lea    0x0(%esi),%esi
    name[len] = 0;
80101f38:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101f3b:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
    memmove(name, s, len);
80101f3e:	83 ec 04             	sub    $0x4,%esp
80101f41:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80101f44:	50                   	push   %eax
80101f45:	53                   	push   %ebx
    name[len] = 0;
80101f46:	89 fb                	mov    %edi,%ebx
    memmove(name, s, len);
80101f48:	ff 75 e4             	push   -0x1c(%ebp)
80101f4b:	e8 e0 28 00 00       	call   80104830 <memmove>
    name[len] = 0;
80101f50:	8b 4d e0             	mov    -0x20(%ebp),%ecx
80101f53:	83 c4 10             	add    $0x10,%esp
80101f56:	c6 01 00             	movb   $0x0,(%ecx)
80101f59:	e9 41 ff ff ff       	jmp    80101e9f <namex+0x9f>
80101f5e:	66 90                	xchg   %ax,%ax
  }
  if(nameiparent){
80101f60:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101f63:	85 c0                	test   %eax,%eax
80101f65:	0f 85 93 00 00 00    	jne    80101ffe <namex+0x1fe>
    iput(ip);
    return 0;
  }
  return ip;
}
80101f6b:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101f6e:	89 f0                	mov    %esi,%eax
80101f70:	5b                   	pop    %ebx
80101f71:	5e                   	pop    %esi
80101f72:	5f                   	pop    %edi
80101f73:	5d                   	pop    %ebp
80101f74:	c3                   	ret
  while(*path != '/' && *path != 0)
80101f75:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80101f78:	89 df                	mov    %ebx,%edi
80101f7a:	31 c0                	xor    %eax,%eax
80101f7c:	eb c0                	jmp    80101f3e <namex+0x13e>
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80101f7e:	83 ec 0c             	sub    $0xc,%esp
80101f81:	8d 5e 0c             	lea    0xc(%esi),%ebx
80101f84:	53                   	push   %ebx
80101f85:	e8 d6 24 00 00       	call   80104460 <holdingsleep>
80101f8a:	83 c4 10             	add    $0x10,%esp
80101f8d:	85 c0                	test   %eax,%eax
80101f8f:	74 7d                	je     8010200e <namex+0x20e>
80101f91:	8b 4e 08             	mov    0x8(%esi),%ecx
80101f94:	85 c9                	test   %ecx,%ecx
80101f96:	7e 76                	jle    8010200e <namex+0x20e>
  releasesleep(&ip->lock);
80101f98:	83 ec 0c             	sub    $0xc,%esp
80101f9b:	53                   	push   %ebx
80101f9c:	e8 7f 24 00 00       	call   80104420 <releasesleep>
  iput(ip);
80101fa1:	89 34 24             	mov    %esi,(%esp)
      return 0;
80101fa4:	31 f6                	xor    %esi,%esi
  iput(ip);
80101fa6:	e8 85 f9 ff ff       	call   80101930 <iput>
      return 0;
80101fab:	83 c4 10             	add    $0x10,%esp
}
80101fae:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101fb1:	89 f0                	mov    %esi,%eax
80101fb3:	5b                   	pop    %ebx
80101fb4:	5e                   	pop    %esi
80101fb5:	5f                   	pop    %edi
80101fb6:	5d                   	pop    %ebp
80101fb7:	c3                   	ret
    ip = iget(ROOTDEV, ROOTINO);
80101fb8:	ba 01 00 00 00       	mov    $0x1,%edx
80101fbd:	b8 01 00 00 00       	mov    $0x1,%eax
80101fc2:	e8 89 f3 ff ff       	call   80101350 <iget>
80101fc7:	89 c6                	mov    %eax,%esi
80101fc9:	e9 7d fe ff ff       	jmp    80101e4b <namex+0x4b>
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80101fce:	83 ec 0c             	sub    $0xc,%esp
80101fd1:	8d 5e 0c             	lea    0xc(%esi),%ebx
80101fd4:	53                   	push   %ebx
80101fd5:	e8 86 24 00 00       	call   80104460 <holdingsleep>
80101fda:	83 c4 10             	add    $0x10,%esp
80101fdd:	85 c0                	test   %eax,%eax
80101fdf:	74 2d                	je     8010200e <namex+0x20e>
80101fe1:	8b 7e 08             	mov    0x8(%esi),%edi
80101fe4:	85 ff                	test   %edi,%edi
80101fe6:	7e 26                	jle    8010200e <namex+0x20e>
  releasesleep(&ip->lock);
80101fe8:	83 ec 0c             	sub    $0xc,%esp
80101feb:	53                   	push   %ebx
80101fec:	e8 2f 24 00 00       	call   80104420 <releasesleep>
}
80101ff1:	83 c4 10             	add    $0x10,%esp
}
80101ff4:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101ff7:	89 f0                	mov    %esi,%eax
80101ff9:	5b                   	pop    %ebx
80101ffa:	5e                   	pop    %esi
80101ffb:	5f                   	pop    %edi
80101ffc:	5d                   	pop    %ebp
80101ffd:	c3                   	ret
    iput(ip);
80101ffe:	83 ec 0c             	sub    $0xc,%esp
80102001:	56                   	push   %esi
      return 0;
80102002:	31 f6                	xor    %esi,%esi
    iput(ip);
80102004:	e8 27 f9 ff ff       	call   80101930 <iput>
    return 0;
80102009:	83 c4 10             	add    $0x10,%esp
8010200c:	eb a0                	jmp    80101fae <namex+0x1ae>
    panic("iunlock");
8010200e:	83 ec 0c             	sub    $0xc,%esp
80102011:	68 8e 83 10 80       	push   $0x8010838e
80102016:	e8 65 e3 ff ff       	call   80100380 <panic>
8010201b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80102020 <dirlink>:
{
80102020:	55                   	push   %ebp
80102021:	89 e5                	mov    %esp,%ebp
80102023:	57                   	push   %edi
80102024:	56                   	push   %esi
80102025:	53                   	push   %ebx
80102026:	83 ec 20             	sub    $0x20,%esp
80102029:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if((ip = dirlookup(dp, name, 0)) != 0){
8010202c:	6a 00                	push   $0x0
8010202e:	ff 75 0c             	push   0xc(%ebp)
80102031:	53                   	push   %ebx
80102032:	e8 19 fd ff ff       	call   80101d50 <dirlookup>
80102037:	83 c4 10             	add    $0x10,%esp
8010203a:	85 c0                	test   %eax,%eax
8010203c:	75 67                	jne    801020a5 <dirlink+0x85>
  for(off = 0; off < dp->size; off += sizeof(de)){
8010203e:	8b 7b 58             	mov    0x58(%ebx),%edi
80102041:	8d 75 d8             	lea    -0x28(%ebp),%esi
80102044:	85 ff                	test   %edi,%edi
80102046:	74 29                	je     80102071 <dirlink+0x51>
80102048:	31 ff                	xor    %edi,%edi
8010204a:	8d 75 d8             	lea    -0x28(%ebp),%esi
8010204d:	eb 09                	jmp    80102058 <dirlink+0x38>
8010204f:	90                   	nop
80102050:	83 c7 10             	add    $0x10,%edi
80102053:	3b 7b 58             	cmp    0x58(%ebx),%edi
80102056:	73 19                	jae    80102071 <dirlink+0x51>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80102058:	6a 10                	push   $0x10
8010205a:	57                   	push   %edi
8010205b:	56                   	push   %esi
8010205c:	53                   	push   %ebx
8010205d:	e8 ae fa ff ff       	call   80101b10 <readi>
80102062:	83 c4 10             	add    $0x10,%esp
80102065:	83 f8 10             	cmp    $0x10,%eax
80102068:	75 4e                	jne    801020b8 <dirlink+0x98>
    if(de.inum == 0)
8010206a:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
8010206f:	75 df                	jne    80102050 <dirlink+0x30>
  strncpy(de.name, name, DIRSIZ);
80102071:	83 ec 04             	sub    $0x4,%esp
80102074:	8d 45 da             	lea    -0x26(%ebp),%eax
80102077:	6a 0e                	push   $0xe
80102079:	ff 75 0c             	push   0xc(%ebp)
8010207c:	50                   	push   %eax
8010207d:	e8 6e 28 00 00       	call   801048f0 <strncpy>
  de.inum = inum;
80102082:	8b 45 10             	mov    0x10(%ebp),%eax
80102085:	66 89 45 d8          	mov    %ax,-0x28(%ebp)
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80102089:	6a 10                	push   $0x10
8010208b:	57                   	push   %edi
8010208c:	56                   	push   %esi
8010208d:	53                   	push   %ebx
8010208e:	e8 7d fb ff ff       	call   80101c10 <writei>
80102093:	83 c4 20             	add    $0x20,%esp
80102096:	83 f8 10             	cmp    $0x10,%eax
80102099:	75 2a                	jne    801020c5 <dirlink+0xa5>
  return 0;
8010209b:	31 c0                	xor    %eax,%eax
}
8010209d:	8d 65 f4             	lea    -0xc(%ebp),%esp
801020a0:	5b                   	pop    %ebx
801020a1:	5e                   	pop    %esi
801020a2:	5f                   	pop    %edi
801020a3:	5d                   	pop    %ebp
801020a4:	c3                   	ret
    iput(ip);
801020a5:	83 ec 0c             	sub    $0xc,%esp
801020a8:	50                   	push   %eax
801020a9:	e8 82 f8 ff ff       	call   80101930 <iput>
    return -1;
801020ae:	83 c4 10             	add    $0x10,%esp
801020b1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801020b6:	eb e5                	jmp    8010209d <dirlink+0x7d>
      panic("dirlink read");
801020b8:	83 ec 0c             	sub    $0xc,%esp
801020bb:	68 b7 83 10 80       	push   $0x801083b7
801020c0:	e8 bb e2 ff ff       	call   80100380 <panic>
    panic("dirlink");
801020c5:	83 ec 0c             	sub    $0xc,%esp
801020c8:	68 13 86 10 80       	push   $0x80108613
801020cd:	e8 ae e2 ff ff       	call   80100380 <panic>
801020d2:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801020d9:	00 
801020da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801020e0 <namei>:

struct inode*
namei(char *path)
{
801020e0:	55                   	push   %ebp
  char name[DIRSIZ];
  return namex(path, 0, name);
801020e1:	31 d2                	xor    %edx,%edx
{
801020e3:	89 e5                	mov    %esp,%ebp
801020e5:	83 ec 18             	sub    $0x18,%esp
  return namex(path, 0, name);
801020e8:	8b 45 08             	mov    0x8(%ebp),%eax
801020eb:	8d 4d ea             	lea    -0x16(%ebp),%ecx
801020ee:	e8 0d fd ff ff       	call   80101e00 <namex>
}
801020f3:	c9                   	leave
801020f4:	c3                   	ret
801020f5:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801020fc:	00 
801020fd:	8d 76 00             	lea    0x0(%esi),%esi

80102100 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
80102100:	55                   	push   %ebp
  return namex(path, 1, name);
80102101:	ba 01 00 00 00       	mov    $0x1,%edx
{
80102106:	89 e5                	mov    %esp,%ebp
  return namex(path, 1, name);
80102108:	8b 4d 0c             	mov    0xc(%ebp),%ecx
8010210b:	8b 45 08             	mov    0x8(%ebp),%eax
}
8010210e:	5d                   	pop    %ebp
  return namex(path, 1, name);
8010210f:	e9 ec fc ff ff       	jmp    80101e00 <namex>
80102114:	66 90                	xchg   %ax,%ax
80102116:	66 90                	xchg   %ax,%ax
80102118:	66 90                	xchg   %ax,%ax
8010211a:	66 90                	xchg   %ax,%ax
8010211c:	66 90                	xchg   %ax,%ax
8010211e:	66 90                	xchg   %ax,%ax

80102120 <idestart>:
}

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
80102120:	55                   	push   %ebp
80102121:	89 e5                	mov    %esp,%ebp
80102123:	57                   	push   %edi
80102124:	56                   	push   %esi
80102125:	53                   	push   %ebx
80102126:	83 ec 0c             	sub    $0xc,%esp
  if(b == 0)
80102129:	85 c0                	test   %eax,%eax
8010212b:	0f 84 b4 00 00 00    	je     801021e5 <idestart+0xc5>
    panic("idestart");
  if(b->blockno >= FSSIZE)
80102131:	8b 70 08             	mov    0x8(%eax),%esi
80102134:	89 c3                	mov    %eax,%ebx
80102136:	81 fe e7 03 00 00    	cmp    $0x3e7,%esi
8010213c:	0f 87 96 00 00 00    	ja     801021d8 <idestart+0xb8>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102142:	b9 f7 01 00 00       	mov    $0x1f7,%ecx
80102147:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010214e:	00 
8010214f:	90                   	nop
80102150:	89 ca                	mov    %ecx,%edx
80102152:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102153:	83 e0 c0             	and    $0xffffffc0,%eax
80102156:	3c 40                	cmp    $0x40,%al
80102158:	75 f6                	jne    80102150 <idestart+0x30>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010215a:	31 ff                	xor    %edi,%edi
8010215c:	ba f6 03 00 00       	mov    $0x3f6,%edx
80102161:	89 f8                	mov    %edi,%eax
80102163:	ee                   	out    %al,(%dx)
80102164:	b8 01 00 00 00       	mov    $0x1,%eax
80102169:	ba f2 01 00 00       	mov    $0x1f2,%edx
8010216e:	ee                   	out    %al,(%dx)
8010216f:	ba f3 01 00 00       	mov    $0x1f3,%edx
80102174:	89 f0                	mov    %esi,%eax
80102176:	ee                   	out    %al,(%dx)

  idewait(0);
  outb(0x3f6, 0);  // generate interrupt
  outb(0x1f2, sector_per_block);  // number of sectors
  outb(0x1f3, sector & 0xff);
  outb(0x1f4, (sector >> 8) & 0xff);
80102177:	89 f0                	mov    %esi,%eax
80102179:	ba f4 01 00 00       	mov    $0x1f4,%edx
8010217e:	c1 f8 08             	sar    $0x8,%eax
80102181:	ee                   	out    %al,(%dx)
80102182:	ba f5 01 00 00       	mov    $0x1f5,%edx
80102187:	89 f8                	mov    %edi,%eax
80102189:	ee                   	out    %al,(%dx)
  outb(0x1f5, (sector >> 16) & 0xff);
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
8010218a:	0f b6 43 04          	movzbl 0x4(%ebx),%eax
8010218e:	ba f6 01 00 00       	mov    $0x1f6,%edx
80102193:	c1 e0 04             	shl    $0x4,%eax
80102196:	83 e0 10             	and    $0x10,%eax
80102199:	83 c8 e0             	or     $0xffffffe0,%eax
8010219c:	ee                   	out    %al,(%dx)
  if(b->flags & B_DIRTY){
8010219d:	f6 03 04             	testb  $0x4,(%ebx)
801021a0:	75 16                	jne    801021b8 <idestart+0x98>
801021a2:	b8 20 00 00 00       	mov    $0x20,%eax
801021a7:	89 ca                	mov    %ecx,%edx
801021a9:	ee                   	out    %al,(%dx)
    outb(0x1f7, write_cmd);
    outsl(0x1f0, b->data, BSIZE/4);
  } else {
    outb(0x1f7, read_cmd);
  }
}
801021aa:	8d 65 f4             	lea    -0xc(%ebp),%esp
801021ad:	5b                   	pop    %ebx
801021ae:	5e                   	pop    %esi
801021af:	5f                   	pop    %edi
801021b0:	5d                   	pop    %ebp
801021b1:	c3                   	ret
801021b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801021b8:	b8 30 00 00 00       	mov    $0x30,%eax
801021bd:	89 ca                	mov    %ecx,%edx
801021bf:	ee                   	out    %al,(%dx)
  asm volatile("cld; rep outsl" :
801021c0:	b9 80 00 00 00       	mov    $0x80,%ecx
    outsl(0x1f0, b->data, BSIZE/4);
801021c5:	8d 73 5c             	lea    0x5c(%ebx),%esi
801021c8:	ba f0 01 00 00       	mov    $0x1f0,%edx
801021cd:	fc                   	cld
801021ce:	f3 6f                	rep outsl %ds:(%esi),(%dx)
}
801021d0:	8d 65 f4             	lea    -0xc(%ebp),%esp
801021d3:	5b                   	pop    %ebx
801021d4:	5e                   	pop    %esi
801021d5:	5f                   	pop    %edi
801021d6:	5d                   	pop    %ebp
801021d7:	c3                   	ret
    panic("incorrect blockno");
801021d8:	83 ec 0c             	sub    $0xc,%esp
801021db:	68 cd 83 10 80       	push   $0x801083cd
801021e0:	e8 9b e1 ff ff       	call   80100380 <panic>
    panic("idestart");
801021e5:	83 ec 0c             	sub    $0xc,%esp
801021e8:	68 c4 83 10 80       	push   $0x801083c4
801021ed:	e8 8e e1 ff ff       	call   80100380 <panic>
801021f2:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801021f9:	00 
801021fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80102200 <ideinit>:
{
80102200:	55                   	push   %ebp
80102201:	89 e5                	mov    %esp,%ebp
80102203:	83 ec 10             	sub    $0x10,%esp
  initlock(&idelock, "ide");
80102206:	68 df 83 10 80       	push   $0x801083df
8010220b:	68 60 a6 13 80       	push   $0x8013a660
80102210:	e8 9b 22 00 00       	call   801044b0 <initlock>
  ioapicenable(IRQ_IDE, ncpu - 1);
80102215:	58                   	pop    %eax
80102216:	a1 e4 a7 13 80       	mov    0x8013a7e4,%eax
8010221b:	5a                   	pop    %edx
8010221c:	83 e8 01             	sub    $0x1,%eax
8010221f:	50                   	push   %eax
80102220:	6a 0e                	push   $0xe
80102222:	e8 99 02 00 00       	call   801024c0 <ioapicenable>
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102227:	83 c4 10             	add    $0x10,%esp
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010222a:	b9 f7 01 00 00       	mov    $0x1f7,%ecx
8010222f:	90                   	nop
80102230:	89 ca                	mov    %ecx,%edx
80102232:	ec                   	in     (%dx),%al
80102233:	83 e0 c0             	and    $0xffffffc0,%eax
80102236:	3c 40                	cmp    $0x40,%al
80102238:	75 f6                	jne    80102230 <ideinit+0x30>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010223a:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
8010223f:	ba f6 01 00 00       	mov    $0x1f6,%edx
80102244:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102245:	89 ca                	mov    %ecx,%edx
80102247:	ec                   	in     (%dx),%al
    if(inb(0x1f7) != 0){
80102248:	84 c0                	test   %al,%al
8010224a:	75 1e                	jne    8010226a <ideinit+0x6a>
8010224c:	b9 e8 03 00 00       	mov    $0x3e8,%ecx
80102251:	ba f7 01 00 00       	mov    $0x1f7,%edx
80102256:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010225d:	00 
8010225e:	66 90                	xchg   %ax,%ax
  for(i=0; i<1000; i++){
80102260:	83 e9 01             	sub    $0x1,%ecx
80102263:	74 0f                	je     80102274 <ideinit+0x74>
80102265:	ec                   	in     (%dx),%al
    if(inb(0x1f7) != 0){
80102266:	84 c0                	test   %al,%al
80102268:	74 f6                	je     80102260 <ideinit+0x60>
      havedisk1 = 1;
8010226a:	c7 05 40 a6 13 80 01 	movl   $0x1,0x8013a640
80102271:	00 00 00 
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102274:	b8 e0 ff ff ff       	mov    $0xffffffe0,%eax
80102279:	ba f6 01 00 00       	mov    $0x1f6,%edx
8010227e:	ee                   	out    %al,(%dx)
}
8010227f:	c9                   	leave
80102280:	c3                   	ret
80102281:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102288:	00 
80102289:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102290 <ideintr>:

// Interrupt handler.
void
ideintr(void)
{
80102290:	55                   	push   %ebp
80102291:	89 e5                	mov    %esp,%ebp
80102293:	57                   	push   %edi
80102294:	56                   	push   %esi
80102295:	53                   	push   %ebx
80102296:	83 ec 18             	sub    $0x18,%esp
  struct buf *b;

  // First queued buffer is the active request.
  acquire(&idelock);
80102299:	68 60 a6 13 80       	push   $0x8013a660
8010229e:	e8 fd 23 00 00       	call   801046a0 <acquire>

  if((b = idequeue) == 0){
801022a3:	8b 1d 44 a6 13 80    	mov    0x8013a644,%ebx
801022a9:	83 c4 10             	add    $0x10,%esp
801022ac:	85 db                	test   %ebx,%ebx
801022ae:	74 63                	je     80102313 <ideintr+0x83>
    release(&idelock);
    return;
  }
  idequeue = b->qnext;
801022b0:	8b 43 58             	mov    0x58(%ebx),%eax
801022b3:	a3 44 a6 13 80       	mov    %eax,0x8013a644

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
801022b8:	8b 33                	mov    (%ebx),%esi
801022ba:	f7 c6 04 00 00 00    	test   $0x4,%esi
801022c0:	75 2f                	jne    801022f1 <ideintr+0x61>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801022c2:	ba f7 01 00 00       	mov    $0x1f7,%edx
801022c7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801022ce:	00 
801022cf:	90                   	nop
801022d0:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
801022d1:	89 c1                	mov    %eax,%ecx
801022d3:	83 e1 c0             	and    $0xffffffc0,%ecx
801022d6:	80 f9 40             	cmp    $0x40,%cl
801022d9:	75 f5                	jne    801022d0 <ideintr+0x40>
  if(checkerr && (r & (IDE_DF|IDE_ERR)) != 0)
801022db:	a8 21                	test   $0x21,%al
801022dd:	75 12                	jne    801022f1 <ideintr+0x61>
    insl(0x1f0, b->data, BSIZE/4);
801022df:	8d 7b 5c             	lea    0x5c(%ebx),%edi
  asm volatile("cld; rep insl" :
801022e2:	b9 80 00 00 00       	mov    $0x80,%ecx
801022e7:	ba f0 01 00 00       	mov    $0x1f0,%edx
801022ec:	fc                   	cld
801022ed:	f3 6d                	rep insl (%dx),%es:(%edi)

  // Wake process waiting for this buf.
  b->flags |= B_VALID;
801022ef:	8b 33                	mov    (%ebx),%esi
  b->flags &= ~B_DIRTY;
801022f1:	83 e6 fb             	and    $0xfffffffb,%esi
  wakeup(b);
801022f4:	83 ec 0c             	sub    $0xc,%esp
  b->flags &= ~B_DIRTY;
801022f7:	83 ce 02             	or     $0x2,%esi
801022fa:	89 33                	mov    %esi,(%ebx)
  wakeup(b);
801022fc:	53                   	push   %ebx
801022fd:	e8 de 1e 00 00       	call   801041e0 <wakeup>

  // Start disk on next buf in queue.
  if(idequeue != 0)
80102302:	a1 44 a6 13 80       	mov    0x8013a644,%eax
80102307:	83 c4 10             	add    $0x10,%esp
8010230a:	85 c0                	test   %eax,%eax
8010230c:	74 05                	je     80102313 <ideintr+0x83>
    idestart(idequeue);
8010230e:	e8 0d fe ff ff       	call   80102120 <idestart>
    release(&idelock);
80102313:	83 ec 0c             	sub    $0xc,%esp
80102316:	68 60 a6 13 80       	push   $0x8013a660
8010231b:	e8 20 23 00 00       	call   80104640 <release>

  release(&idelock);
}
80102320:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102323:	5b                   	pop    %ebx
80102324:	5e                   	pop    %esi
80102325:	5f                   	pop    %edi
80102326:	5d                   	pop    %ebp
80102327:	c3                   	ret
80102328:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010232f:	00 

80102330 <iderw>:
// Sync buf with disk.
// If B_DIRTY is set, write buf to disk, clear B_DIRTY, set B_VALID.
// Else if B_VALID is not set, read buf from disk, set B_VALID.
void
iderw(struct buf *b)
{
80102330:	55                   	push   %ebp
80102331:	89 e5                	mov    %esp,%ebp
80102333:	53                   	push   %ebx
80102334:	83 ec 10             	sub    $0x10,%esp
80102337:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf **pp;

  if(!holdingsleep(&b->lock))
8010233a:	8d 43 0c             	lea    0xc(%ebx),%eax
8010233d:	50                   	push   %eax
8010233e:	e8 1d 21 00 00       	call   80104460 <holdingsleep>
80102343:	83 c4 10             	add    $0x10,%esp
80102346:	85 c0                	test   %eax,%eax
80102348:	0f 84 c3 00 00 00    	je     80102411 <iderw+0xe1>
    panic("iderw: buf not locked");
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
8010234e:	8b 03                	mov    (%ebx),%eax
80102350:	83 e0 06             	and    $0x6,%eax
80102353:	83 f8 02             	cmp    $0x2,%eax
80102356:	0f 84 a8 00 00 00    	je     80102404 <iderw+0xd4>
    panic("iderw: nothing to do");
  if(b->dev != 0 && !havedisk1)
8010235c:	8b 53 04             	mov    0x4(%ebx),%edx
8010235f:	85 d2                	test   %edx,%edx
80102361:	74 0d                	je     80102370 <iderw+0x40>
80102363:	a1 40 a6 13 80       	mov    0x8013a640,%eax
80102368:	85 c0                	test   %eax,%eax
8010236a:	0f 84 87 00 00 00    	je     801023f7 <iderw+0xc7>
    panic("iderw: ide disk 1 not present");

  acquire(&idelock);  //DOC:acquire-lock
80102370:	83 ec 0c             	sub    $0xc,%esp
80102373:	68 60 a6 13 80       	push   $0x8013a660
80102378:	e8 23 23 00 00       	call   801046a0 <acquire>

  // Append b to idequeue.
  b->qnext = 0;
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
8010237d:	a1 44 a6 13 80       	mov    0x8013a644,%eax
  b->qnext = 0;
80102382:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
80102389:	83 c4 10             	add    $0x10,%esp
8010238c:	85 c0                	test   %eax,%eax
8010238e:	74 60                	je     801023f0 <iderw+0xc0>
80102390:	89 c2                	mov    %eax,%edx
80102392:	8b 40 58             	mov    0x58(%eax),%eax
80102395:	85 c0                	test   %eax,%eax
80102397:	75 f7                	jne    80102390 <iderw+0x60>
80102399:	83 c2 58             	add    $0x58,%edx
    ;
  *pp = b;
8010239c:	89 1a                	mov    %ebx,(%edx)

  // Start disk if necessary.
  if(idequeue == b)
8010239e:	39 1d 44 a6 13 80    	cmp    %ebx,0x8013a644
801023a4:	74 3a                	je     801023e0 <iderw+0xb0>
    idestart(b);

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
801023a6:	8b 03                	mov    (%ebx),%eax
801023a8:	83 e0 06             	and    $0x6,%eax
801023ab:	83 f8 02             	cmp    $0x2,%eax
801023ae:	74 1b                	je     801023cb <iderw+0x9b>
    sleep(b, &idelock);
801023b0:	83 ec 08             	sub    $0x8,%esp
801023b3:	68 60 a6 13 80       	push   $0x8013a660
801023b8:	53                   	push   %ebx
801023b9:	e8 62 1d 00 00       	call   80104120 <sleep>
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
801023be:	8b 03                	mov    (%ebx),%eax
801023c0:	83 c4 10             	add    $0x10,%esp
801023c3:	83 e0 06             	and    $0x6,%eax
801023c6:	83 f8 02             	cmp    $0x2,%eax
801023c9:	75 e5                	jne    801023b0 <iderw+0x80>
  }


  release(&idelock);
801023cb:	c7 45 08 60 a6 13 80 	movl   $0x8013a660,0x8(%ebp)
}
801023d2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801023d5:	c9                   	leave
  release(&idelock);
801023d6:	e9 65 22 00 00       	jmp    80104640 <release>
801023db:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    idestart(b);
801023e0:	89 d8                	mov    %ebx,%eax
801023e2:	e8 39 fd ff ff       	call   80102120 <idestart>
801023e7:	eb bd                	jmp    801023a6 <iderw+0x76>
801023e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
801023f0:	ba 44 a6 13 80       	mov    $0x8013a644,%edx
801023f5:	eb a5                	jmp    8010239c <iderw+0x6c>
    panic("iderw: ide disk 1 not present");
801023f7:	83 ec 0c             	sub    $0xc,%esp
801023fa:	68 0e 84 10 80       	push   $0x8010840e
801023ff:	e8 7c df ff ff       	call   80100380 <panic>
    panic("iderw: nothing to do");
80102404:	83 ec 0c             	sub    $0xc,%esp
80102407:	68 f9 83 10 80       	push   $0x801083f9
8010240c:	e8 6f df ff ff       	call   80100380 <panic>
    panic("iderw: buf not locked");
80102411:	83 ec 0c             	sub    $0xc,%esp
80102414:	68 e3 83 10 80       	push   $0x801083e3
80102419:	e8 62 df ff ff       	call   80100380 <panic>
8010241e:	66 90                	xchg   %ax,%ax

80102420 <ioapicinit>:
  ioapic->data = data;
}

void
ioapicinit(void)
{
80102420:	55                   	push   %ebp
80102421:	89 e5                	mov    %esp,%ebp
80102423:	56                   	push   %esi
80102424:	53                   	push   %ebx
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
80102425:	c7 05 94 a6 13 80 00 	movl   $0xfec00000,0x8013a694
8010242c:	00 c0 fe 
  ioapic->reg = reg;
8010242f:	c7 05 00 00 c0 fe 01 	movl   $0x1,0xfec00000
80102436:	00 00 00 
  return ioapic->data;
80102439:	8b 15 94 a6 13 80    	mov    0x8013a694,%edx
8010243f:	8b 72 10             	mov    0x10(%edx),%esi
  ioapic->reg = reg;
80102442:	c7 02 00 00 00 00    	movl   $0x0,(%edx)
  return ioapic->data;
80102448:	8b 1d 94 a6 13 80    	mov    0x8013a694,%ebx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  id = ioapicread(REG_ID) >> 24;
  if(id != ioapicid)
8010244e:	0f b6 15 e0 a7 13 80 	movzbl 0x8013a7e0,%edx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
80102455:	c1 ee 10             	shr    $0x10,%esi
80102458:	89 f0                	mov    %esi,%eax
8010245a:	0f b6 f0             	movzbl %al,%esi
  return ioapic->data;
8010245d:	8b 43 10             	mov    0x10(%ebx),%eax
  id = ioapicread(REG_ID) >> 24;
80102460:	c1 e8 18             	shr    $0x18,%eax
  if(id != ioapicid)
80102463:	39 c2                	cmp    %eax,%edx
80102465:	74 16                	je     8010247d <ioapicinit+0x5d>
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");
80102467:	83 ec 0c             	sub    $0xc,%esp
8010246a:	68 cc 88 10 80       	push   $0x801088cc
8010246f:	e8 3c e2 ff ff       	call   801006b0 <cprintf>
  ioapic->reg = reg;
80102474:	8b 1d 94 a6 13 80    	mov    0x8013a694,%ebx
8010247a:	83 c4 10             	add    $0x10,%esp
{
8010247d:	ba 10 00 00 00       	mov    $0x10,%edx
80102482:	31 c0                	xor    %eax,%eax
80102484:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  ioapic->reg = reg;
80102488:	89 13                	mov    %edx,(%ebx)
8010248a:	8d 48 20             	lea    0x20(%eax),%ecx
  ioapic->data = data;
8010248d:	8b 1d 94 a6 13 80    	mov    0x8013a694,%ebx

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
80102493:	83 c0 01             	add    $0x1,%eax
80102496:	81 c9 00 00 01 00    	or     $0x10000,%ecx
  ioapic->data = data;
8010249c:	89 4b 10             	mov    %ecx,0x10(%ebx)
  ioapic->reg = reg;
8010249f:	8d 4a 01             	lea    0x1(%edx),%ecx
  for(i = 0; i <= maxintr; i++){
801024a2:	83 c2 02             	add    $0x2,%edx
  ioapic->reg = reg;
801024a5:	89 0b                	mov    %ecx,(%ebx)
  ioapic->data = data;
801024a7:	8b 1d 94 a6 13 80    	mov    0x8013a694,%ebx
801024ad:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
  for(i = 0; i <= maxintr; i++){
801024b4:	39 c6                	cmp    %eax,%esi
801024b6:	7d d0                	jge    80102488 <ioapicinit+0x68>
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
    ioapicwrite(REG_TABLE+2*i+1, 0);
  }
}
801024b8:	8d 65 f8             	lea    -0x8(%ebp),%esp
801024bb:	5b                   	pop    %ebx
801024bc:	5e                   	pop    %esi
801024bd:	5d                   	pop    %ebp
801024be:	c3                   	ret
801024bf:	90                   	nop

801024c0 <ioapicenable>:

void
ioapicenable(int irq, int cpunum)
{
801024c0:	55                   	push   %ebp
  ioapic->reg = reg;
801024c1:	8b 0d 94 a6 13 80    	mov    0x8013a694,%ecx
{
801024c7:	89 e5                	mov    %esp,%ebp
801024c9:	8b 45 08             	mov    0x8(%ebp),%eax
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
801024cc:	8d 50 20             	lea    0x20(%eax),%edx
801024cf:	8d 44 00 10          	lea    0x10(%eax,%eax,1),%eax
  ioapic->reg = reg;
801024d3:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
801024d5:	8b 0d 94 a6 13 80    	mov    0x8013a694,%ecx
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
801024db:	83 c0 01             	add    $0x1,%eax
  ioapic->data = data;
801024de:	89 51 10             	mov    %edx,0x10(%ecx)
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
801024e1:	8b 55 0c             	mov    0xc(%ebp),%edx
  ioapic->reg = reg;
801024e4:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
801024e6:	a1 94 a6 13 80       	mov    0x8013a694,%eax
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
801024eb:	c1 e2 18             	shl    $0x18,%edx
  ioapic->data = data;
801024ee:	89 50 10             	mov    %edx,0x10(%eax)
}
801024f1:	5d                   	pop    %ebp
801024f2:	c3                   	ret
801024f3:	66 90                	xchg   %ax,%ax
801024f5:	66 90                	xchg   %ax,%ax
801024f7:	66 90                	xchg   %ax,%ax
801024f9:	66 90                	xchg   %ax,%ax
801024fb:	66 90                	xchg   %ax,%ax
801024fd:	66 90                	xchg   %ax,%ax
801024ff:	90                   	nop

80102500 <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(char *v)
{
80102500:	55                   	push   %ebp
80102501:	89 e5                	mov    %esp,%ebp
80102503:	53                   	push   %ebx
80102504:	83 ec 04             	sub    $0x4,%esp
80102507:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct run *r;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
8010250a:	f7 c3 ff 0f 00 00    	test   $0xfff,%ebx
80102510:	75 76                	jne    80102588 <kfree+0x88>
80102512:	81 fb 50 e5 33 80    	cmp    $0x8033e550,%ebx
80102518:	72 6e                	jb     80102588 <kfree+0x88>
8010251a:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80102520:	3d ff ff ff 0d       	cmp    $0xdffffff,%eax
80102525:	77 61                	ja     80102588 <kfree+0x88>
    panic("kfree");

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);
80102527:	83 ec 04             	sub    $0x4,%esp
8010252a:	68 00 10 00 00       	push   $0x1000
8010252f:	6a 01                	push   $0x1
80102531:	53                   	push   %ebx
80102532:	e8 69 22 00 00       	call   801047a0 <memset>

  if(kmem.use_lock)
80102537:	8b 15 d4 a6 13 80    	mov    0x8013a6d4,%edx
8010253d:	83 c4 10             	add    $0x10,%esp
80102540:	85 d2                	test   %edx,%edx
80102542:	75 1c                	jne    80102560 <kfree+0x60>
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
80102544:	a1 d8 a6 13 80       	mov    0x8013a6d8,%eax
80102549:	89 03                	mov    %eax,(%ebx)
  kmem.freelist = r;
  if(kmem.use_lock)
8010254b:	a1 d4 a6 13 80       	mov    0x8013a6d4,%eax
  kmem.freelist = r;
80102550:	89 1d d8 a6 13 80    	mov    %ebx,0x8013a6d8
  if(kmem.use_lock)
80102556:	85 c0                	test   %eax,%eax
80102558:	75 1e                	jne    80102578 <kfree+0x78>
    release(&kmem.lock);
}
8010255a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010255d:	c9                   	leave
8010255e:	c3                   	ret
8010255f:	90                   	nop
    acquire(&kmem.lock);
80102560:	83 ec 0c             	sub    $0xc,%esp
80102563:	68 a0 a6 13 80       	push   $0x8013a6a0
80102568:	e8 33 21 00 00       	call   801046a0 <acquire>
8010256d:	83 c4 10             	add    $0x10,%esp
80102570:	eb d2                	jmp    80102544 <kfree+0x44>
80102572:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    release(&kmem.lock);
80102578:	c7 45 08 a0 a6 13 80 	movl   $0x8013a6a0,0x8(%ebp)
}
8010257f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102582:	c9                   	leave
    release(&kmem.lock);
80102583:	e9 b8 20 00 00       	jmp    80104640 <release>
    panic("kfree");
80102588:	83 ec 0c             	sub    $0xc,%esp
8010258b:	68 2c 84 10 80       	push   $0x8010842c
80102590:	e8 eb dd ff ff       	call   80100380 <panic>
80102595:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010259c:	00 
8010259d:	8d 76 00             	lea    0x0(%esi),%esi

801025a0 <freerange>:
{
801025a0:	55                   	push   %ebp
801025a1:	89 e5                	mov    %esp,%ebp
801025a3:	56                   	push   %esi
801025a4:	53                   	push   %ebx
  p = (char*)PGROUNDUP((uint)vstart);
801025a5:	8b 45 08             	mov    0x8(%ebp),%eax
{
801025a8:	8b 75 0c             	mov    0xc(%ebp),%esi
  p = (char*)PGROUNDUP((uint)vstart);
801025ab:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
801025b1:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801025b7:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801025bd:	39 de                	cmp    %ebx,%esi
801025bf:	72 23                	jb     801025e4 <freerange+0x44>
801025c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
801025c8:	83 ec 0c             	sub    $0xc,%esp
801025cb:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801025d1:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
801025d7:	50                   	push   %eax
801025d8:	e8 23 ff ff ff       	call   80102500 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801025dd:	83 c4 10             	add    $0x10,%esp
801025e0:	39 de                	cmp    %ebx,%esi
801025e2:	73 e4                	jae    801025c8 <freerange+0x28>
}
801025e4:	8d 65 f8             	lea    -0x8(%ebp),%esp
801025e7:	5b                   	pop    %ebx
801025e8:	5e                   	pop    %esi
801025e9:	5d                   	pop    %ebp
801025ea:	c3                   	ret
801025eb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

801025f0 <kinit2>:
{
801025f0:	55                   	push   %ebp
801025f1:	89 e5                	mov    %esp,%ebp
801025f3:	56                   	push   %esi
801025f4:	53                   	push   %ebx
  p = (char*)PGROUNDUP((uint)vstart);
801025f5:	8b 45 08             	mov    0x8(%ebp),%eax
{
801025f8:	8b 75 0c             	mov    0xc(%ebp),%esi
  p = (char*)PGROUNDUP((uint)vstart);
801025fb:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102601:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102607:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010260d:	39 de                	cmp    %ebx,%esi
8010260f:	72 23                	jb     80102634 <kinit2+0x44>
80102611:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
80102618:	83 ec 0c             	sub    $0xc,%esp
8010261b:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102621:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
80102627:	50                   	push   %eax
80102628:	e8 d3 fe ff ff       	call   80102500 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010262d:	83 c4 10             	add    $0x10,%esp
80102630:	39 de                	cmp    %ebx,%esi
80102632:	73 e4                	jae    80102618 <kinit2+0x28>
  kmem.use_lock = 1;
80102634:	c7 05 d4 a6 13 80 01 	movl   $0x1,0x8013a6d4
8010263b:	00 00 00 
}
8010263e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102641:	5b                   	pop    %ebx
80102642:	5e                   	pop    %esi
80102643:	5d                   	pop    %ebp
80102644:	c3                   	ret
80102645:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010264c:	00 
8010264d:	8d 76 00             	lea    0x0(%esi),%esi

80102650 <kinit1>:
{
80102650:	55                   	push   %ebp
80102651:	89 e5                	mov    %esp,%ebp
80102653:	56                   	push   %esi
80102654:	53                   	push   %ebx
80102655:	8b 75 0c             	mov    0xc(%ebp),%esi
  initlock(&kmem.lock, "kmem");
80102658:	83 ec 08             	sub    $0x8,%esp
8010265b:	68 32 84 10 80       	push   $0x80108432
80102660:	68 a0 a6 13 80       	push   $0x8013a6a0
80102665:	e8 46 1e 00 00       	call   801044b0 <initlock>
  p = (char*)PGROUNDUP((uint)vstart);
8010266a:	8b 45 08             	mov    0x8(%ebp),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010266d:	83 c4 10             	add    $0x10,%esp
  kmem.use_lock = 0;
80102670:	c7 05 d4 a6 13 80 00 	movl   $0x0,0x8013a6d4
80102677:	00 00 00 
  p = (char*)PGROUNDUP((uint)vstart);
8010267a:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102680:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102686:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010268c:	39 de                	cmp    %ebx,%esi
8010268e:	72 1c                	jb     801026ac <kinit1+0x5c>
    kfree(p);
80102690:	83 ec 0c             	sub    $0xc,%esp
80102693:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102699:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
8010269f:	50                   	push   %eax
801026a0:	e8 5b fe ff ff       	call   80102500 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801026a5:	83 c4 10             	add    $0x10,%esp
801026a8:	39 de                	cmp    %ebx,%esi
801026aa:	73 e4                	jae    80102690 <kinit1+0x40>
}
801026ac:	8d 65 f8             	lea    -0x8(%ebp),%esp
801026af:	5b                   	pop    %ebx
801026b0:	5e                   	pop    %esi
801026b1:	5d                   	pop    %ebp
801026b2:	c3                   	ret
801026b3:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801026ba:	00 
801026bb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

801026c0 <kalloc>:
// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
char*
kalloc(void)
{
801026c0:	55                   	push   %ebp
801026c1:	89 e5                	mov    %esp,%ebp
801026c3:	53                   	push   %ebx
801026c4:	83 ec 04             	sub    $0x4,%esp
  struct run *r;

  if(kmem.use_lock)
801026c7:	a1 d4 a6 13 80       	mov    0x8013a6d4,%eax
801026cc:	85 c0                	test   %eax,%eax
801026ce:	75 20                	jne    801026f0 <kalloc+0x30>
    acquire(&kmem.lock);
  r = kmem.freelist;
801026d0:	8b 1d d8 a6 13 80    	mov    0x8013a6d8,%ebx
  if(r)
801026d6:	85 db                	test   %ebx,%ebx
801026d8:	74 07                	je     801026e1 <kalloc+0x21>
    kmem.freelist = r->next;
801026da:	8b 03                	mov    (%ebx),%eax
801026dc:	a3 d8 a6 13 80       	mov    %eax,0x8013a6d8
  if(kmem.use_lock)
    release(&kmem.lock);
  return (char*)r;
}
801026e1:	89 d8                	mov    %ebx,%eax
801026e3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801026e6:	c9                   	leave
801026e7:	c3                   	ret
801026e8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801026ef:	00 
    acquire(&kmem.lock);
801026f0:	83 ec 0c             	sub    $0xc,%esp
801026f3:	68 a0 a6 13 80       	push   $0x8013a6a0
801026f8:	e8 a3 1f 00 00       	call   801046a0 <acquire>
  r = kmem.freelist;
801026fd:	8b 1d d8 a6 13 80    	mov    0x8013a6d8,%ebx
  if(kmem.use_lock)
80102703:	a1 d4 a6 13 80       	mov    0x8013a6d4,%eax
  if(r)
80102708:	83 c4 10             	add    $0x10,%esp
8010270b:	85 db                	test   %ebx,%ebx
8010270d:	74 08                	je     80102717 <kalloc+0x57>
    kmem.freelist = r->next;
8010270f:	8b 13                	mov    (%ebx),%edx
80102711:	89 15 d8 a6 13 80    	mov    %edx,0x8013a6d8
  if(kmem.use_lock)
80102717:	85 c0                	test   %eax,%eax
80102719:	74 c6                	je     801026e1 <kalloc+0x21>
    release(&kmem.lock);
8010271b:	83 ec 0c             	sub    $0xc,%esp
8010271e:	68 a0 a6 13 80       	push   $0x8013a6a0
80102723:	e8 18 1f 00 00       	call   80104640 <release>
}
80102728:	89 d8                	mov    %ebx,%eax
    release(&kmem.lock);
8010272a:	83 c4 10             	add    $0x10,%esp
}
8010272d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102730:	c9                   	leave
80102731:	c3                   	ret
80102732:	66 90                	xchg   %ax,%ax
80102734:	66 90                	xchg   %ax,%ax
80102736:	66 90                	xchg   %ax,%ax
80102738:	66 90                	xchg   %ax,%ax
8010273a:	66 90                	xchg   %ax,%ax
8010273c:	66 90                	xchg   %ax,%ax
8010273e:	66 90                	xchg   %ax,%ax

80102740 <kbdgetc>:
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102740:	ba 64 00 00 00       	mov    $0x64,%edx
80102745:	ec                   	in     (%dx),%al
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
  if((st & KBS_DIB) == 0)
80102746:	a8 01                	test   $0x1,%al
80102748:	0f 84 c2 00 00 00    	je     80102810 <kbdgetc+0xd0>
{
8010274e:	55                   	push   %ebp
8010274f:	ba 60 00 00 00       	mov    $0x60,%edx
80102754:	89 e5                	mov    %esp,%ebp
80102756:	53                   	push   %ebx
80102757:	ec                   	in     (%dx),%al
    return -1;
  data = inb(KBDATAP);

  if(data == 0xE0){
    shift |= E0ESC;
80102758:	8b 1d dc a6 13 80    	mov    0x8013a6dc,%ebx
  data = inb(KBDATAP);
8010275e:	0f b6 c8             	movzbl %al,%ecx
  if(data == 0xE0){
80102761:	3c e0                	cmp    $0xe0,%al
80102763:	74 5b                	je     801027c0 <kbdgetc+0x80>
    return 0;
  } else if(data & 0x80){
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
80102765:	89 da                	mov    %ebx,%edx
80102767:	83 e2 40             	and    $0x40,%edx
  } else if(data & 0x80){
8010276a:	84 c0                	test   %al,%al
8010276c:	78 62                	js     801027d0 <kbdgetc+0x90>
    shift &= ~(shiftcode[data] | E0ESC);
    return 0;
  } else if(shift & E0ESC){
8010276e:	85 d2                	test   %edx,%edx
80102770:	74 09                	je     8010277b <kbdgetc+0x3b>
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
80102772:	83 c8 80             	or     $0xffffff80,%eax
    shift &= ~E0ESC;
80102775:	83 e3 bf             	and    $0xffffffbf,%ebx
    data |= 0x80;
80102778:	0f b6 c8             	movzbl %al,%ecx
  }

  shift |= shiftcode[data];
8010277b:	0f b6 91 c0 8b 10 80 	movzbl -0x7fef7440(%ecx),%edx
  shift ^= togglecode[data];
80102782:	0f b6 81 c0 8a 10 80 	movzbl -0x7fef7540(%ecx),%eax
  shift |= shiftcode[data];
80102789:	09 da                	or     %ebx,%edx
  shift ^= togglecode[data];
8010278b:	31 c2                	xor    %eax,%edx
  c = charcode[shift & (CTL | SHIFT)][data];
8010278d:	89 d0                	mov    %edx,%eax
  shift ^= togglecode[data];
8010278f:	89 15 dc a6 13 80    	mov    %edx,0x8013a6dc
  c = charcode[shift & (CTL | SHIFT)][data];
80102795:	83 e0 03             	and    $0x3,%eax
  if(shift & CAPSLOCK){
80102798:	83 e2 08             	and    $0x8,%edx
  c = charcode[shift & (CTL | SHIFT)][data];
8010279b:	8b 04 85 a0 8a 10 80 	mov    -0x7fef7560(,%eax,4),%eax
801027a2:	0f b6 04 08          	movzbl (%eax,%ecx,1),%eax
  if(shift & CAPSLOCK){
801027a6:	74 0b                	je     801027b3 <kbdgetc+0x73>
    if('a' <= c && c <= 'z')
801027a8:	8d 50 9f             	lea    -0x61(%eax),%edx
801027ab:	83 fa 19             	cmp    $0x19,%edx
801027ae:	77 48                	ja     801027f8 <kbdgetc+0xb8>
      c += 'A' - 'a';
801027b0:	83 e8 20             	sub    $0x20,%eax
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
801027b3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801027b6:	c9                   	leave
801027b7:	c3                   	ret
801027b8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801027bf:	00 
    shift |= E0ESC;
801027c0:	83 cb 40             	or     $0x40,%ebx
    return 0;
801027c3:	31 c0                	xor    %eax,%eax
    shift |= E0ESC;
801027c5:	89 1d dc a6 13 80    	mov    %ebx,0x8013a6dc
}
801027cb:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801027ce:	c9                   	leave
801027cf:	c3                   	ret
    data = (shift & E0ESC ? data : data & 0x7F);
801027d0:	83 e0 7f             	and    $0x7f,%eax
801027d3:	85 d2                	test   %edx,%edx
801027d5:	0f 44 c8             	cmove  %eax,%ecx
    shift &= ~(shiftcode[data] | E0ESC);
801027d8:	0f b6 81 c0 8b 10 80 	movzbl -0x7fef7440(%ecx),%eax
801027df:	83 c8 40             	or     $0x40,%eax
801027e2:	0f b6 c0             	movzbl %al,%eax
801027e5:	f7 d0                	not    %eax
801027e7:	21 d8                	and    %ebx,%eax
801027e9:	a3 dc a6 13 80       	mov    %eax,0x8013a6dc
    return 0;
801027ee:	31 c0                	xor    %eax,%eax
801027f0:	eb d9                	jmp    801027cb <kbdgetc+0x8b>
801027f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    else if('A' <= c && c <= 'Z')
801027f8:	8d 48 bf             	lea    -0x41(%eax),%ecx
      c += 'a' - 'A';
801027fb:	8d 50 20             	lea    0x20(%eax),%edx
}
801027fe:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102801:	c9                   	leave
      c += 'a' - 'A';
80102802:	83 f9 1a             	cmp    $0x1a,%ecx
80102805:	0f 42 c2             	cmovb  %edx,%eax
}
80102808:	c3                   	ret
80102809:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80102810:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80102815:	c3                   	ret
80102816:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010281d:	00 
8010281e:	66 90                	xchg   %ax,%ax

80102820 <kbdintr>:

void
kbdintr(void)
{
80102820:	55                   	push   %ebp
80102821:	89 e5                	mov    %esp,%ebp
80102823:	83 ec 14             	sub    $0x14,%esp
  consoleintr(kbdgetc);
80102826:	68 40 27 10 80       	push   $0x80102740
8010282b:	e8 70 e0 ff ff       	call   801008a0 <consoleintr>
}
80102830:	83 c4 10             	add    $0x10,%esp
80102833:	c9                   	leave
80102834:	c3                   	ret
80102835:	66 90                	xchg   %ax,%ax
80102837:	66 90                	xchg   %ax,%ax
80102839:	66 90                	xchg   %ax,%ax
8010283b:	66 90                	xchg   %ax,%ax
8010283d:	66 90                	xchg   %ax,%ax
8010283f:	90                   	nop

80102840 <lapicinit>:
}

void
lapicinit(void)
{
  if(!lapic)
80102840:	a1 e0 a6 13 80       	mov    0x8013a6e0,%eax
80102845:	85 c0                	test   %eax,%eax
80102847:	0f 84 c3 00 00 00    	je     80102910 <lapicinit+0xd0>
  lapic[index] = value;
8010284d:	c7 80 f0 00 00 00 3f 	movl   $0x13f,0xf0(%eax)
80102854:	01 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102857:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010285a:	c7 80 e0 03 00 00 0b 	movl   $0xb,0x3e0(%eax)
80102861:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102864:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102867:	c7 80 20 03 00 00 20 	movl   $0x20020,0x320(%eax)
8010286e:	00 02 00 
  lapic[ID];  // wait for write to finish, by reading
80102871:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102874:	c7 80 80 03 00 00 80 	movl   $0x989680,0x380(%eax)
8010287b:	96 98 00 
  lapic[ID];  // wait for write to finish, by reading
8010287e:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102881:	c7 80 50 03 00 00 00 	movl   $0x10000,0x350(%eax)
80102888:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
8010288b:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010288e:	c7 80 60 03 00 00 00 	movl   $0x10000,0x360(%eax)
80102895:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
80102898:	8b 50 20             	mov    0x20(%eax),%edx
  lapicw(LINT0, MASKED);
  lapicw(LINT1, MASKED);

  // Disable performance counter overflow interrupts
  // on machines that provide that interrupt entry.
  if(((lapic[VER]>>16) & 0xFF) >= 4)
8010289b:	8b 50 30             	mov    0x30(%eax),%edx
8010289e:	81 e2 00 00 fc 00    	and    $0xfc0000,%edx
801028a4:	75 72                	jne    80102918 <lapicinit+0xd8>
  lapic[index] = value;
801028a6:	c7 80 70 03 00 00 33 	movl   $0x33,0x370(%eax)
801028ad:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801028b0:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801028b3:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
801028ba:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801028bd:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801028c0:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
801028c7:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801028ca:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801028cd:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
801028d4:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801028d7:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801028da:	c7 80 10 03 00 00 00 	movl   $0x0,0x310(%eax)
801028e1:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801028e4:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801028e7:	c7 80 00 03 00 00 00 	movl   $0x88500,0x300(%eax)
801028ee:	85 08 00 
  lapic[ID];  // wait for write to finish, by reading
801028f1:	8b 50 20             	mov    0x20(%eax),%edx
  lapicw(EOI, 0);

  // Send an Init Level De-Assert to synchronise arbitration ID's.
  lapicw(ICRHI, 0);
  lapicw(ICRLO, BCAST | INIT | LEVEL);
  while(lapic[ICRLO] & DELIVS)
801028f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801028f8:	8b 90 00 03 00 00    	mov    0x300(%eax),%edx
801028fe:	80 e6 10             	and    $0x10,%dh
80102901:	75 f5                	jne    801028f8 <lapicinit+0xb8>
  lapic[index] = value;
80102903:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%eax)
8010290a:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010290d:	8b 40 20             	mov    0x20(%eax),%eax
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
}
80102910:	c3                   	ret
80102911:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  lapic[index] = value;
80102918:	c7 80 40 03 00 00 00 	movl   $0x10000,0x340(%eax)
8010291f:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
80102922:	8b 50 20             	mov    0x20(%eax),%edx
}
80102925:	e9 7c ff ff ff       	jmp    801028a6 <lapicinit+0x66>
8010292a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80102930 <lapicid>:

int
lapicid(void)
{
  if (!lapic)
80102930:	a1 e0 a6 13 80       	mov    0x8013a6e0,%eax
80102935:	85 c0                	test   %eax,%eax
80102937:	74 07                	je     80102940 <lapicid+0x10>
    return 0;
  return lapic[ID] >> 24;
80102939:	8b 40 20             	mov    0x20(%eax),%eax
8010293c:	c1 e8 18             	shr    $0x18,%eax
8010293f:	c3                   	ret
    return 0;
80102940:	31 c0                	xor    %eax,%eax
}
80102942:	c3                   	ret
80102943:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010294a:	00 
8010294b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80102950 <lapiceoi>:

// Acknowledge interrupt.
void
lapiceoi(void)
{
  if(lapic)
80102950:	a1 e0 a6 13 80       	mov    0x8013a6e0,%eax
80102955:	85 c0                	test   %eax,%eax
80102957:	74 0d                	je     80102966 <lapiceoi+0x16>
  lapic[index] = value;
80102959:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80102960:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102963:	8b 40 20             	mov    0x20(%eax),%eax
    lapicw(EOI, 0);
}
80102966:	c3                   	ret
80102967:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010296e:	00 
8010296f:	90                   	nop

80102970 <microdelay>:
// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
void
microdelay(int us)
{
}
80102970:	c3                   	ret
80102971:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102978:	00 
80102979:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102980 <lapicstartap>:

// Start additional processor running entry code at addr.
// See Appendix B of MultiProcessor Specification.
void
lapicstartap(uchar apicid, uint addr)
{
80102980:	55                   	push   %ebp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102981:	b8 0f 00 00 00       	mov    $0xf,%eax
80102986:	ba 70 00 00 00       	mov    $0x70,%edx
8010298b:	89 e5                	mov    %esp,%ebp
8010298d:	53                   	push   %ebx
8010298e:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80102991:	8b 5d 08             	mov    0x8(%ebp),%ebx
80102994:	ee                   	out    %al,(%dx)
80102995:	b8 0a 00 00 00       	mov    $0xa,%eax
8010299a:	ba 71 00 00 00       	mov    $0x71,%edx
8010299f:	ee                   	out    %al,(%dx)
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
801029a0:	31 c0                	xor    %eax,%eax
  lapic[index] = value;
801029a2:	c1 e3 18             	shl    $0x18,%ebx
  wrv[0] = 0;
801029a5:	66 a3 67 04 00 80    	mov    %ax,0x80000467
  wrv[1] = addr >> 4;
801029ab:	89 c8                	mov    %ecx,%eax
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
801029ad:	c1 e9 0c             	shr    $0xc,%ecx
  lapic[index] = value;
801029b0:	89 da                	mov    %ebx,%edx
  wrv[1] = addr >> 4;
801029b2:	c1 e8 04             	shr    $0x4,%eax
    lapicw(ICRLO, STARTUP | (addr>>12));
801029b5:	80 cd 06             	or     $0x6,%ch
  wrv[1] = addr >> 4;
801029b8:	66 a3 69 04 00 80    	mov    %ax,0x80000469
  lapic[index] = value;
801029be:	a1 e0 a6 13 80       	mov    0x8013a6e0,%eax
801029c3:	89 98 10 03 00 00    	mov    %ebx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
801029c9:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
801029cc:	c7 80 00 03 00 00 00 	movl   $0xc500,0x300(%eax)
801029d3:	c5 00 00 
  lapic[ID];  // wait for write to finish, by reading
801029d6:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
801029d9:	c7 80 00 03 00 00 00 	movl   $0x8500,0x300(%eax)
801029e0:	85 00 00 
  lapic[ID];  // wait for write to finish, by reading
801029e3:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
801029e6:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
801029ec:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
801029ef:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
801029f5:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
801029f8:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
801029fe:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102a01:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102a07:	8b 40 20             	mov    0x20(%eax),%eax
    microdelay(200);
  }
}
80102a0a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102a0d:	c9                   	leave
80102a0e:	c3                   	ret
80102a0f:	90                   	nop

80102a10 <cmostime>:
}

// qemu seems to use 24-hour GWT and the values are BCD encoded
void
cmostime(struct rtcdate *r)
{
80102a10:	55                   	push   %ebp
80102a11:	b8 0b 00 00 00       	mov    $0xb,%eax
80102a16:	ba 70 00 00 00       	mov    $0x70,%edx
80102a1b:	89 e5                	mov    %esp,%ebp
80102a1d:	57                   	push   %edi
80102a1e:	56                   	push   %esi
80102a1f:	53                   	push   %ebx
80102a20:	83 ec 4c             	sub    $0x4c,%esp
80102a23:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102a24:	ba 71 00 00 00       	mov    $0x71,%edx
80102a29:	ec                   	in     (%dx),%al
  struct rtcdate t1, t2;
  int sb, bcd;

  sb = cmos_read(CMOS_STATB);

  bcd = (sb & (1 << 2)) == 0;
80102a2a:	83 e0 04             	and    $0x4,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102a2d:	bf 70 00 00 00       	mov    $0x70,%edi
80102a32:	88 45 b3             	mov    %al,-0x4d(%ebp)
80102a35:	8d 76 00             	lea    0x0(%esi),%esi
80102a38:	31 c0                	xor    %eax,%eax
80102a3a:	89 fa                	mov    %edi,%edx
80102a3c:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102a3d:	b9 71 00 00 00       	mov    $0x71,%ecx
80102a42:	89 ca                	mov    %ecx,%edx
80102a44:	ec                   	in     (%dx),%al
80102a45:	88 45 b7             	mov    %al,-0x49(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102a48:	89 fa                	mov    %edi,%edx
80102a4a:	b8 02 00 00 00       	mov    $0x2,%eax
80102a4f:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102a50:	89 ca                	mov    %ecx,%edx
80102a52:	ec                   	in     (%dx),%al
80102a53:	88 45 b6             	mov    %al,-0x4a(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102a56:	89 fa                	mov    %edi,%edx
80102a58:	b8 04 00 00 00       	mov    $0x4,%eax
80102a5d:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102a5e:	89 ca                	mov    %ecx,%edx
80102a60:	ec                   	in     (%dx),%al
80102a61:	88 45 b5             	mov    %al,-0x4b(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102a64:	89 fa                	mov    %edi,%edx
80102a66:	b8 07 00 00 00       	mov    $0x7,%eax
80102a6b:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102a6c:	89 ca                	mov    %ecx,%edx
80102a6e:	ec                   	in     (%dx),%al
80102a6f:	88 45 b4             	mov    %al,-0x4c(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102a72:	89 fa                	mov    %edi,%edx
80102a74:	b8 08 00 00 00       	mov    $0x8,%eax
80102a79:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102a7a:	89 ca                	mov    %ecx,%edx
80102a7c:	ec                   	in     (%dx),%al
80102a7d:	89 c6                	mov    %eax,%esi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102a7f:	89 fa                	mov    %edi,%edx
80102a81:	b8 09 00 00 00       	mov    $0x9,%eax
80102a86:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102a87:	89 ca                	mov    %ecx,%edx
80102a89:	ec                   	in     (%dx),%al
80102a8a:	0f b6 d8             	movzbl %al,%ebx
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102a8d:	89 fa                	mov    %edi,%edx
80102a8f:	b8 0a 00 00 00       	mov    $0xa,%eax
80102a94:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102a95:	89 ca                	mov    %ecx,%edx
80102a97:	ec                   	in     (%dx),%al

  // make sure CMOS doesn't modify time while we read it
  for(;;) {
    fill_rtcdate(&t1);
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
80102a98:	84 c0                	test   %al,%al
80102a9a:	78 9c                	js     80102a38 <cmostime+0x28>
  return inb(CMOS_RETURN);
80102a9c:	0f b6 45 b7          	movzbl -0x49(%ebp),%eax
80102aa0:	89 f2                	mov    %esi,%edx
80102aa2:	89 5d cc             	mov    %ebx,-0x34(%ebp)
80102aa5:	0f b6 f2             	movzbl %dl,%esi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102aa8:	89 fa                	mov    %edi,%edx
80102aaa:	89 45 b8             	mov    %eax,-0x48(%ebp)
80102aad:	0f b6 45 b6          	movzbl -0x4a(%ebp),%eax
80102ab1:	89 75 c8             	mov    %esi,-0x38(%ebp)
80102ab4:	89 45 bc             	mov    %eax,-0x44(%ebp)
80102ab7:	0f b6 45 b5          	movzbl -0x4b(%ebp),%eax
80102abb:	89 45 c0             	mov    %eax,-0x40(%ebp)
80102abe:	0f b6 45 b4          	movzbl -0x4c(%ebp),%eax
80102ac2:	89 45 c4             	mov    %eax,-0x3c(%ebp)
80102ac5:	31 c0                	xor    %eax,%eax
80102ac7:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102ac8:	89 ca                	mov    %ecx,%edx
80102aca:	ec                   	in     (%dx),%al
80102acb:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102ace:	89 fa                	mov    %edi,%edx
80102ad0:	89 45 d0             	mov    %eax,-0x30(%ebp)
80102ad3:	b8 02 00 00 00       	mov    $0x2,%eax
80102ad8:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102ad9:	89 ca                	mov    %ecx,%edx
80102adb:	ec                   	in     (%dx),%al
80102adc:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102adf:	89 fa                	mov    %edi,%edx
80102ae1:	89 45 d4             	mov    %eax,-0x2c(%ebp)
80102ae4:	b8 04 00 00 00       	mov    $0x4,%eax
80102ae9:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102aea:	89 ca                	mov    %ecx,%edx
80102aec:	ec                   	in     (%dx),%al
80102aed:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102af0:	89 fa                	mov    %edi,%edx
80102af2:	89 45 d8             	mov    %eax,-0x28(%ebp)
80102af5:	b8 07 00 00 00       	mov    $0x7,%eax
80102afa:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102afb:	89 ca                	mov    %ecx,%edx
80102afd:	ec                   	in     (%dx),%al
80102afe:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102b01:	89 fa                	mov    %edi,%edx
80102b03:	89 45 dc             	mov    %eax,-0x24(%ebp)
80102b06:	b8 08 00 00 00       	mov    $0x8,%eax
80102b0b:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102b0c:	89 ca                	mov    %ecx,%edx
80102b0e:	ec                   	in     (%dx),%al
80102b0f:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102b12:	89 fa                	mov    %edi,%edx
80102b14:	89 45 e0             	mov    %eax,-0x20(%ebp)
80102b17:	b8 09 00 00 00       	mov    $0x9,%eax
80102b1c:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102b1d:	89 ca                	mov    %ecx,%edx
80102b1f:	ec                   	in     (%dx),%al
80102b20:	0f b6 c0             	movzbl %al,%eax
        continue;
    fill_rtcdate(&t2);
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
80102b23:	83 ec 04             	sub    $0x4,%esp
  return inb(CMOS_RETURN);
80102b26:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
80102b29:	8d 45 d0             	lea    -0x30(%ebp),%eax
80102b2c:	6a 18                	push   $0x18
80102b2e:	50                   	push   %eax
80102b2f:	8d 45 b8             	lea    -0x48(%ebp),%eax
80102b32:	50                   	push   %eax
80102b33:	e8 a8 1c 00 00       	call   801047e0 <memcmp>
80102b38:	83 c4 10             	add    $0x10,%esp
80102b3b:	85 c0                	test   %eax,%eax
80102b3d:	0f 85 f5 fe ff ff    	jne    80102a38 <cmostime+0x28>
      break;
  }

  // convert
  if(bcd) {
80102b43:	0f b6 75 b3          	movzbl -0x4d(%ebp),%esi
80102b47:	8b 5d 08             	mov    0x8(%ebp),%ebx
80102b4a:	89 f0                	mov    %esi,%eax
80102b4c:	84 c0                	test   %al,%al
80102b4e:	75 78                	jne    80102bc8 <cmostime+0x1b8>
#define    CONV(x)     (t1.x = ((t1.x >> 4) * 10) + (t1.x & 0xf))
    CONV(second);
80102b50:	8b 45 b8             	mov    -0x48(%ebp),%eax
80102b53:	89 c2                	mov    %eax,%edx
80102b55:	83 e0 0f             	and    $0xf,%eax
80102b58:	c1 ea 04             	shr    $0x4,%edx
80102b5b:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102b5e:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102b61:	89 45 b8             	mov    %eax,-0x48(%ebp)
    CONV(minute);
80102b64:	8b 45 bc             	mov    -0x44(%ebp),%eax
80102b67:	89 c2                	mov    %eax,%edx
80102b69:	83 e0 0f             	and    $0xf,%eax
80102b6c:	c1 ea 04             	shr    $0x4,%edx
80102b6f:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102b72:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102b75:	89 45 bc             	mov    %eax,-0x44(%ebp)
    CONV(hour  );
80102b78:	8b 45 c0             	mov    -0x40(%ebp),%eax
80102b7b:	89 c2                	mov    %eax,%edx
80102b7d:	83 e0 0f             	and    $0xf,%eax
80102b80:	c1 ea 04             	shr    $0x4,%edx
80102b83:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102b86:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102b89:	89 45 c0             	mov    %eax,-0x40(%ebp)
    CONV(day   );
80102b8c:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80102b8f:	89 c2                	mov    %eax,%edx
80102b91:	83 e0 0f             	and    $0xf,%eax
80102b94:	c1 ea 04             	shr    $0x4,%edx
80102b97:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102b9a:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102b9d:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    CONV(month );
80102ba0:	8b 45 c8             	mov    -0x38(%ebp),%eax
80102ba3:	89 c2                	mov    %eax,%edx
80102ba5:	83 e0 0f             	and    $0xf,%eax
80102ba8:	c1 ea 04             	shr    $0x4,%edx
80102bab:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102bae:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102bb1:	89 45 c8             	mov    %eax,-0x38(%ebp)
    CONV(year  );
80102bb4:	8b 45 cc             	mov    -0x34(%ebp),%eax
80102bb7:	89 c2                	mov    %eax,%edx
80102bb9:	83 e0 0f             	and    $0xf,%eax
80102bbc:	c1 ea 04             	shr    $0x4,%edx
80102bbf:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102bc2:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102bc5:	89 45 cc             	mov    %eax,-0x34(%ebp)
#undef     CONV
  }

  *r = t1;
80102bc8:	8b 45 b8             	mov    -0x48(%ebp),%eax
80102bcb:	89 03                	mov    %eax,(%ebx)
80102bcd:	8b 45 bc             	mov    -0x44(%ebp),%eax
80102bd0:	89 43 04             	mov    %eax,0x4(%ebx)
80102bd3:	8b 45 c0             	mov    -0x40(%ebp),%eax
80102bd6:	89 43 08             	mov    %eax,0x8(%ebx)
80102bd9:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80102bdc:	89 43 0c             	mov    %eax,0xc(%ebx)
80102bdf:	8b 45 c8             	mov    -0x38(%ebp),%eax
80102be2:	89 43 10             	mov    %eax,0x10(%ebx)
80102be5:	8b 45 cc             	mov    -0x34(%ebp),%eax
80102be8:	89 43 14             	mov    %eax,0x14(%ebx)
  r->year += 2000;
80102beb:	81 43 14 d0 07 00 00 	addl   $0x7d0,0x14(%ebx)
}
80102bf2:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102bf5:	5b                   	pop    %ebx
80102bf6:	5e                   	pop    %esi
80102bf7:	5f                   	pop    %edi
80102bf8:	5d                   	pop    %ebp
80102bf9:	c3                   	ret
80102bfa:	66 90                	xchg   %ax,%ax
80102bfc:	66 90                	xchg   %ax,%ax
80102bfe:	66 90                	xchg   %ax,%ax

80102c00 <install_trans>:
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102c00:	8b 0d 48 a7 13 80    	mov    0x8013a748,%ecx
80102c06:	85 c9                	test   %ecx,%ecx
80102c08:	0f 8e 8a 00 00 00    	jle    80102c98 <install_trans+0x98>
{
80102c0e:	55                   	push   %ebp
80102c0f:	89 e5                	mov    %esp,%ebp
80102c11:	57                   	push   %edi
  for (tail = 0; tail < log.lh.n; tail++) {
80102c12:	31 ff                	xor    %edi,%edi
{
80102c14:	56                   	push   %esi
80102c15:	53                   	push   %ebx
80102c16:	83 ec 0c             	sub    $0xc,%esp
80102c19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
80102c20:	a1 34 a7 13 80       	mov    0x8013a734,%eax
80102c25:	83 ec 08             	sub    $0x8,%esp
80102c28:	01 f8                	add    %edi,%eax
80102c2a:	83 c0 01             	add    $0x1,%eax
80102c2d:	50                   	push   %eax
80102c2e:	ff 35 44 a7 13 80    	push   0x8013a744
80102c34:	e8 97 d4 ff ff       	call   801000d0 <bread>
80102c39:	89 c6                	mov    %eax,%esi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102c3b:	58                   	pop    %eax
80102c3c:	5a                   	pop    %edx
80102c3d:	ff 34 bd 4c a7 13 80 	push   -0x7fec58b4(,%edi,4)
80102c44:	ff 35 44 a7 13 80    	push   0x8013a744
  for (tail = 0; tail < log.lh.n; tail++) {
80102c4a:	83 c7 01             	add    $0x1,%edi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102c4d:	e8 7e d4 ff ff       	call   801000d0 <bread>
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
80102c52:	83 c4 0c             	add    $0xc,%esp
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102c55:	89 c3                	mov    %eax,%ebx
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
80102c57:	8d 46 5c             	lea    0x5c(%esi),%eax
80102c5a:	68 00 02 00 00       	push   $0x200
80102c5f:	50                   	push   %eax
80102c60:	8d 43 5c             	lea    0x5c(%ebx),%eax
80102c63:	50                   	push   %eax
80102c64:	e8 c7 1b 00 00       	call   80104830 <memmove>
    bwrite(dbuf);  // write dst to disk
80102c69:	89 1c 24             	mov    %ebx,(%esp)
80102c6c:	e8 3f d5 ff ff       	call   801001b0 <bwrite>
    brelse(lbuf);
80102c71:	89 34 24             	mov    %esi,(%esp)
80102c74:	e8 77 d5 ff ff       	call   801001f0 <brelse>
    brelse(dbuf);
80102c79:	89 1c 24             	mov    %ebx,(%esp)
80102c7c:	e8 6f d5 ff ff       	call   801001f0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
80102c81:	83 c4 10             	add    $0x10,%esp
80102c84:	39 3d 48 a7 13 80    	cmp    %edi,0x8013a748
80102c8a:	7f 94                	jg     80102c20 <install_trans+0x20>
  }
}
80102c8c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102c8f:	5b                   	pop    %ebx
80102c90:	5e                   	pop    %esi
80102c91:	5f                   	pop    %edi
80102c92:	5d                   	pop    %ebp
80102c93:	c3                   	ret
80102c94:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102c98:	c3                   	ret
80102c99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102ca0 <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
80102ca0:	55                   	push   %ebp
80102ca1:	89 e5                	mov    %esp,%ebp
80102ca3:	53                   	push   %ebx
80102ca4:	83 ec 0c             	sub    $0xc,%esp
  struct buf *buf = bread(log.dev, log.start);
80102ca7:	ff 35 34 a7 13 80    	push   0x8013a734
80102cad:	ff 35 44 a7 13 80    	push   0x8013a744
80102cb3:	e8 18 d4 ff ff       	call   801000d0 <bread>
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
  for (i = 0; i < log.lh.n; i++) {
80102cb8:	83 c4 10             	add    $0x10,%esp
  struct buf *buf = bread(log.dev, log.start);
80102cbb:	89 c3                	mov    %eax,%ebx
  hb->n = log.lh.n;
80102cbd:	a1 48 a7 13 80       	mov    0x8013a748,%eax
80102cc2:	89 43 5c             	mov    %eax,0x5c(%ebx)
  for (i = 0; i < log.lh.n; i++) {
80102cc5:	85 c0                	test   %eax,%eax
80102cc7:	7e 19                	jle    80102ce2 <write_head+0x42>
80102cc9:	31 d2                	xor    %edx,%edx
80102ccb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    hb->block[i] = log.lh.block[i];
80102cd0:	8b 0c 95 4c a7 13 80 	mov    -0x7fec58b4(,%edx,4),%ecx
80102cd7:	89 4c 93 60          	mov    %ecx,0x60(%ebx,%edx,4)
  for (i = 0; i < log.lh.n; i++) {
80102cdb:	83 c2 01             	add    $0x1,%edx
80102cde:	39 d0                	cmp    %edx,%eax
80102ce0:	75 ee                	jne    80102cd0 <write_head+0x30>
  }
  bwrite(buf);
80102ce2:	83 ec 0c             	sub    $0xc,%esp
80102ce5:	53                   	push   %ebx
80102ce6:	e8 c5 d4 ff ff       	call   801001b0 <bwrite>
  brelse(buf);
80102ceb:	89 1c 24             	mov    %ebx,(%esp)
80102cee:	e8 fd d4 ff ff       	call   801001f0 <brelse>
}
80102cf3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102cf6:	83 c4 10             	add    $0x10,%esp
80102cf9:	c9                   	leave
80102cfa:	c3                   	ret
80102cfb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80102d00 <initlog>:
{
80102d00:	55                   	push   %ebp
80102d01:	89 e5                	mov    %esp,%ebp
80102d03:	53                   	push   %ebx
80102d04:	83 ec 2c             	sub    $0x2c,%esp
80102d07:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&log.lock, "log");
80102d0a:	68 37 84 10 80       	push   $0x80108437
80102d0f:	68 00 a7 13 80       	push   $0x8013a700
80102d14:	e8 97 17 00 00       	call   801044b0 <initlock>
  readsb(dev, &sb);
80102d19:	58                   	pop    %eax
80102d1a:	8d 45 dc             	lea    -0x24(%ebp),%eax
80102d1d:	5a                   	pop    %edx
80102d1e:	50                   	push   %eax
80102d1f:	53                   	push   %ebx
80102d20:	e8 7b e8 ff ff       	call   801015a0 <readsb>
  log.start = sb.logstart;
80102d25:	8b 45 ec             	mov    -0x14(%ebp),%eax
  struct buf *buf = bread(log.dev, log.start);
80102d28:	59                   	pop    %ecx
  log.dev = dev;
80102d29:	89 1d 44 a7 13 80    	mov    %ebx,0x8013a744
  log.size = sb.nlog;
80102d2f:	8b 55 e8             	mov    -0x18(%ebp),%edx
  log.start = sb.logstart;
80102d32:	a3 34 a7 13 80       	mov    %eax,0x8013a734
  log.size = sb.nlog;
80102d37:	89 15 38 a7 13 80    	mov    %edx,0x8013a738
  struct buf *buf = bread(log.dev, log.start);
80102d3d:	5a                   	pop    %edx
80102d3e:	50                   	push   %eax
80102d3f:	53                   	push   %ebx
80102d40:	e8 8b d3 ff ff       	call   801000d0 <bread>
  for (i = 0; i < log.lh.n; i++) {
80102d45:	83 c4 10             	add    $0x10,%esp
  log.lh.n = lh->n;
80102d48:	8b 58 5c             	mov    0x5c(%eax),%ebx
80102d4b:	89 1d 48 a7 13 80    	mov    %ebx,0x8013a748
  for (i = 0; i < log.lh.n; i++) {
80102d51:	85 db                	test   %ebx,%ebx
80102d53:	7e 1d                	jle    80102d72 <initlog+0x72>
80102d55:	31 d2                	xor    %edx,%edx
80102d57:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102d5e:	00 
80102d5f:	90                   	nop
    log.lh.block[i] = lh->block[i];
80102d60:	8b 4c 90 60          	mov    0x60(%eax,%edx,4),%ecx
80102d64:	89 0c 95 4c a7 13 80 	mov    %ecx,-0x7fec58b4(,%edx,4)
  for (i = 0; i < log.lh.n; i++) {
80102d6b:	83 c2 01             	add    $0x1,%edx
80102d6e:	39 d3                	cmp    %edx,%ebx
80102d70:	75 ee                	jne    80102d60 <initlog+0x60>
  brelse(buf);
80102d72:	83 ec 0c             	sub    $0xc,%esp
80102d75:	50                   	push   %eax
80102d76:	e8 75 d4 ff ff       	call   801001f0 <brelse>

static void
recover_from_log(void)
{
  read_head();
  install_trans(); // if committed, copy from log to disk
80102d7b:	e8 80 fe ff ff       	call   80102c00 <install_trans>
  log.lh.n = 0;
80102d80:	c7 05 48 a7 13 80 00 	movl   $0x0,0x8013a748
80102d87:	00 00 00 
  write_head(); // clear the log
80102d8a:	e8 11 ff ff ff       	call   80102ca0 <write_head>
}
80102d8f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102d92:	83 c4 10             	add    $0x10,%esp
80102d95:	c9                   	leave
80102d96:	c3                   	ret
80102d97:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102d9e:	00 
80102d9f:	90                   	nop

80102da0 <begin_op>:
}

// called at the start of each FS system call.
void
begin_op(void)
{
80102da0:	55                   	push   %ebp
80102da1:	89 e5                	mov    %esp,%ebp
80102da3:	83 ec 14             	sub    $0x14,%esp
  acquire(&log.lock);
80102da6:	68 00 a7 13 80       	push   $0x8013a700
80102dab:	e8 f0 18 00 00       	call   801046a0 <acquire>
80102db0:	83 c4 10             	add    $0x10,%esp
80102db3:	eb 18                	jmp    80102dcd <begin_op+0x2d>
80102db5:	8d 76 00             	lea    0x0(%esi),%esi
  while(1){
    if(log.committing){
      sleep(&log, &log.lock);
80102db8:	83 ec 08             	sub    $0x8,%esp
80102dbb:	68 00 a7 13 80       	push   $0x8013a700
80102dc0:	68 00 a7 13 80       	push   $0x8013a700
80102dc5:	e8 56 13 00 00       	call   80104120 <sleep>
80102dca:	83 c4 10             	add    $0x10,%esp
    if(log.committing){
80102dcd:	a1 40 a7 13 80       	mov    0x8013a740,%eax
80102dd2:	85 c0                	test   %eax,%eax
80102dd4:	75 e2                	jne    80102db8 <begin_op+0x18>
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
80102dd6:	a1 3c a7 13 80       	mov    0x8013a73c,%eax
80102ddb:	8b 15 48 a7 13 80    	mov    0x8013a748,%edx
80102de1:	83 c0 01             	add    $0x1,%eax
80102de4:	8d 0c 80             	lea    (%eax,%eax,4),%ecx
80102de7:	8d 14 4a             	lea    (%edx,%ecx,2),%edx
80102dea:	83 fa 1e             	cmp    $0x1e,%edx
80102ded:	7f c9                	jg     80102db8 <begin_op+0x18>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    } else {
      log.outstanding += 1;
      release(&log.lock);
80102def:	83 ec 0c             	sub    $0xc,%esp
      log.outstanding += 1;
80102df2:	a3 3c a7 13 80       	mov    %eax,0x8013a73c
      release(&log.lock);
80102df7:	68 00 a7 13 80       	push   $0x8013a700
80102dfc:	e8 3f 18 00 00       	call   80104640 <release>
      break;
    }
  }
}
80102e01:	83 c4 10             	add    $0x10,%esp
80102e04:	c9                   	leave
80102e05:	c3                   	ret
80102e06:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102e0d:	00 
80102e0e:	66 90                	xchg   %ax,%ax

80102e10 <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
80102e10:	55                   	push   %ebp
80102e11:	89 e5                	mov    %esp,%ebp
80102e13:	57                   	push   %edi
80102e14:	56                   	push   %esi
80102e15:	53                   	push   %ebx
80102e16:	83 ec 18             	sub    $0x18,%esp
  int do_commit = 0;

  acquire(&log.lock);
80102e19:	68 00 a7 13 80       	push   $0x8013a700
80102e1e:	e8 7d 18 00 00       	call   801046a0 <acquire>
  log.outstanding -= 1;
80102e23:	a1 3c a7 13 80       	mov    0x8013a73c,%eax
  if(log.committing)
80102e28:	8b 35 40 a7 13 80    	mov    0x8013a740,%esi
80102e2e:	83 c4 10             	add    $0x10,%esp
  log.outstanding -= 1;
80102e31:	8d 58 ff             	lea    -0x1(%eax),%ebx
80102e34:	89 1d 3c a7 13 80    	mov    %ebx,0x8013a73c
  if(log.committing)
80102e3a:	85 f6                	test   %esi,%esi
80102e3c:	0f 85 22 01 00 00    	jne    80102f64 <end_op+0x154>
    panic("log.committing");
  if(log.outstanding == 0){
80102e42:	85 db                	test   %ebx,%ebx
80102e44:	0f 85 f6 00 00 00    	jne    80102f40 <end_op+0x130>
    do_commit = 1;
    log.committing = 1;
80102e4a:	c7 05 40 a7 13 80 01 	movl   $0x1,0x8013a740
80102e51:	00 00 00 
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
80102e54:	83 ec 0c             	sub    $0xc,%esp
80102e57:	68 00 a7 13 80       	push   $0x8013a700
80102e5c:	e8 df 17 00 00       	call   80104640 <release>
}

static void
commit()
{
  if (log.lh.n > 0) {
80102e61:	8b 0d 48 a7 13 80    	mov    0x8013a748,%ecx
80102e67:	83 c4 10             	add    $0x10,%esp
80102e6a:	85 c9                	test   %ecx,%ecx
80102e6c:	7f 42                	jg     80102eb0 <end_op+0xa0>
    acquire(&log.lock);
80102e6e:	83 ec 0c             	sub    $0xc,%esp
80102e71:	68 00 a7 13 80       	push   $0x8013a700
80102e76:	e8 25 18 00 00       	call   801046a0 <acquire>
    log.committing = 0;
80102e7b:	c7 05 40 a7 13 80 00 	movl   $0x0,0x8013a740
80102e82:	00 00 00 
    wakeup(&log);
80102e85:	c7 04 24 00 a7 13 80 	movl   $0x8013a700,(%esp)
80102e8c:	e8 4f 13 00 00       	call   801041e0 <wakeup>
    release(&log.lock);
80102e91:	c7 04 24 00 a7 13 80 	movl   $0x8013a700,(%esp)
80102e98:	e8 a3 17 00 00       	call   80104640 <release>
80102e9d:	83 c4 10             	add    $0x10,%esp
}
80102ea0:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102ea3:	5b                   	pop    %ebx
80102ea4:	5e                   	pop    %esi
80102ea5:	5f                   	pop    %edi
80102ea6:	5d                   	pop    %ebp
80102ea7:	c3                   	ret
80102ea8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102eaf:	00 
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
80102eb0:	a1 34 a7 13 80       	mov    0x8013a734,%eax
80102eb5:	83 ec 08             	sub    $0x8,%esp
80102eb8:	01 d8                	add    %ebx,%eax
80102eba:	83 c0 01             	add    $0x1,%eax
80102ebd:	50                   	push   %eax
80102ebe:	ff 35 44 a7 13 80    	push   0x8013a744
80102ec4:	e8 07 d2 ff ff       	call   801000d0 <bread>
80102ec9:	89 c6                	mov    %eax,%esi
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102ecb:	58                   	pop    %eax
80102ecc:	5a                   	pop    %edx
80102ecd:	ff 34 9d 4c a7 13 80 	push   -0x7fec58b4(,%ebx,4)
80102ed4:	ff 35 44 a7 13 80    	push   0x8013a744
  for (tail = 0; tail < log.lh.n; tail++) {
80102eda:	83 c3 01             	add    $0x1,%ebx
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102edd:	e8 ee d1 ff ff       	call   801000d0 <bread>
    memmove(to->data, from->data, BSIZE);
80102ee2:	83 c4 0c             	add    $0xc,%esp
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102ee5:	89 c7                	mov    %eax,%edi
    memmove(to->data, from->data, BSIZE);
80102ee7:	8d 40 5c             	lea    0x5c(%eax),%eax
80102eea:	68 00 02 00 00       	push   $0x200
80102eef:	50                   	push   %eax
80102ef0:	8d 46 5c             	lea    0x5c(%esi),%eax
80102ef3:	50                   	push   %eax
80102ef4:	e8 37 19 00 00       	call   80104830 <memmove>
    bwrite(to);  // write the log
80102ef9:	89 34 24             	mov    %esi,(%esp)
80102efc:	e8 af d2 ff ff       	call   801001b0 <bwrite>
    brelse(from);
80102f01:	89 3c 24             	mov    %edi,(%esp)
80102f04:	e8 e7 d2 ff ff       	call   801001f0 <brelse>
    brelse(to);
80102f09:	89 34 24             	mov    %esi,(%esp)
80102f0c:	e8 df d2 ff ff       	call   801001f0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
80102f11:	83 c4 10             	add    $0x10,%esp
80102f14:	3b 1d 48 a7 13 80    	cmp    0x8013a748,%ebx
80102f1a:	7c 94                	jl     80102eb0 <end_op+0xa0>
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
80102f1c:	e8 7f fd ff ff       	call   80102ca0 <write_head>
    install_trans(); // Now install writes to home locations
80102f21:	e8 da fc ff ff       	call   80102c00 <install_trans>
    log.lh.n = 0;
80102f26:	c7 05 48 a7 13 80 00 	movl   $0x0,0x8013a748
80102f2d:	00 00 00 
    write_head();    // Erase the transaction from the log
80102f30:	e8 6b fd ff ff       	call   80102ca0 <write_head>
80102f35:	e9 34 ff ff ff       	jmp    80102e6e <end_op+0x5e>
80102f3a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    wakeup(&log);
80102f40:	83 ec 0c             	sub    $0xc,%esp
80102f43:	68 00 a7 13 80       	push   $0x8013a700
80102f48:	e8 93 12 00 00       	call   801041e0 <wakeup>
  release(&log.lock);
80102f4d:	c7 04 24 00 a7 13 80 	movl   $0x8013a700,(%esp)
80102f54:	e8 e7 16 00 00       	call   80104640 <release>
80102f59:	83 c4 10             	add    $0x10,%esp
}
80102f5c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102f5f:	5b                   	pop    %ebx
80102f60:	5e                   	pop    %esi
80102f61:	5f                   	pop    %edi
80102f62:	5d                   	pop    %ebp
80102f63:	c3                   	ret
    panic("log.committing");
80102f64:	83 ec 0c             	sub    $0xc,%esp
80102f67:	68 3b 84 10 80       	push   $0x8010843b
80102f6c:	e8 0f d4 ff ff       	call   80100380 <panic>
80102f71:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102f78:	00 
80102f79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102f80 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
80102f80:	55                   	push   %ebp
80102f81:	89 e5                	mov    %esp,%ebp
80102f83:	53                   	push   %ebx
80102f84:	83 ec 04             	sub    $0x4,%esp
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80102f87:	8b 15 48 a7 13 80    	mov    0x8013a748,%edx
{
80102f8d:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80102f90:	83 fa 1d             	cmp    $0x1d,%edx
80102f93:	7f 7d                	jg     80103012 <log_write+0x92>
80102f95:	a1 38 a7 13 80       	mov    0x8013a738,%eax
80102f9a:	83 e8 01             	sub    $0x1,%eax
80102f9d:	39 c2                	cmp    %eax,%edx
80102f9f:	7d 71                	jge    80103012 <log_write+0x92>
    panic("too big a transaction");
  if (log.outstanding < 1)
80102fa1:	a1 3c a7 13 80       	mov    0x8013a73c,%eax
80102fa6:	85 c0                	test   %eax,%eax
80102fa8:	7e 75                	jle    8010301f <log_write+0x9f>
    panic("log_write outside of trans");

  acquire(&log.lock);
80102faa:	83 ec 0c             	sub    $0xc,%esp
80102fad:	68 00 a7 13 80       	push   $0x8013a700
80102fb2:	e8 e9 16 00 00       	call   801046a0 <acquire>
  for (i = 0; i < log.lh.n; i++) {
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80102fb7:	8b 4b 08             	mov    0x8(%ebx),%ecx
  for (i = 0; i < log.lh.n; i++) {
80102fba:	83 c4 10             	add    $0x10,%esp
80102fbd:	31 c0                	xor    %eax,%eax
80102fbf:	8b 15 48 a7 13 80    	mov    0x8013a748,%edx
80102fc5:	85 d2                	test   %edx,%edx
80102fc7:	7f 0e                	jg     80102fd7 <log_write+0x57>
80102fc9:	eb 15                	jmp    80102fe0 <log_write+0x60>
80102fcb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80102fd0:	83 c0 01             	add    $0x1,%eax
80102fd3:	39 c2                	cmp    %eax,%edx
80102fd5:	74 29                	je     80103000 <log_write+0x80>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80102fd7:	39 0c 85 4c a7 13 80 	cmp    %ecx,-0x7fec58b4(,%eax,4)
80102fde:	75 f0                	jne    80102fd0 <log_write+0x50>
      break;
  }
  log.lh.block[i] = b->blockno;
80102fe0:	89 0c 85 4c a7 13 80 	mov    %ecx,-0x7fec58b4(,%eax,4)
  if (i == log.lh.n)
80102fe7:	39 c2                	cmp    %eax,%edx
80102fe9:	74 1c                	je     80103007 <log_write+0x87>
    log.lh.n++;
  b->flags |= B_DIRTY; // prevent eviction
80102feb:	83 0b 04             	orl    $0x4,(%ebx)
  release(&log.lock);
}
80102fee:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  release(&log.lock);
80102ff1:	c7 45 08 00 a7 13 80 	movl   $0x8013a700,0x8(%ebp)
}
80102ff8:	c9                   	leave
  release(&log.lock);
80102ff9:	e9 42 16 00 00       	jmp    80104640 <release>
80102ffe:	66 90                	xchg   %ax,%ax
  log.lh.block[i] = b->blockno;
80103000:	89 0c 95 4c a7 13 80 	mov    %ecx,-0x7fec58b4(,%edx,4)
    log.lh.n++;
80103007:	83 c2 01             	add    $0x1,%edx
8010300a:	89 15 48 a7 13 80    	mov    %edx,0x8013a748
80103010:	eb d9                	jmp    80102feb <log_write+0x6b>
    panic("too big a transaction");
80103012:	83 ec 0c             	sub    $0xc,%esp
80103015:	68 4a 84 10 80       	push   $0x8010844a
8010301a:	e8 61 d3 ff ff       	call   80100380 <panic>
    panic("log_write outside of trans");
8010301f:	83 ec 0c             	sub    $0xc,%esp
80103022:	68 60 84 10 80       	push   $0x80108460
80103027:	e8 54 d3 ff ff       	call   80100380 <panic>
8010302c:	66 90                	xchg   %ax,%ax
8010302e:	66 90                	xchg   %ax,%ax

80103030 <mpmain>:
}

// Common CPU setup code.
static void
mpmain(void)
{
80103030:	55                   	push   %ebp
80103031:	89 e5                	mov    %esp,%ebp
80103033:	53                   	push   %ebx
80103034:	83 ec 04             	sub    $0x4,%esp
  cprintf("cpu%d: starting %d\n", cpuid(), cpuid());
80103037:	e8 74 09 00 00       	call   801039b0 <cpuid>
8010303c:	89 c3                	mov    %eax,%ebx
8010303e:	e8 6d 09 00 00       	call   801039b0 <cpuid>
80103043:	83 ec 04             	sub    $0x4,%esp
80103046:	53                   	push   %ebx
80103047:	50                   	push   %eax
80103048:	68 7b 84 10 80       	push   $0x8010847b
8010304d:	e8 5e d6 ff ff       	call   801006b0 <cprintf>
  idtinit();       // load idt register
80103052:	e8 79 2b 00 00       	call   80105bd0 <idtinit>
  xchg(&(mycpu()->started), 1); // tell startothers() we're up
80103057:	e8 f4 08 00 00       	call   80103950 <mycpu>
8010305c:	89 c2                	mov    %eax,%edx
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
8010305e:	b8 01 00 00 00       	mov    $0x1,%eax
80103063:	f0 87 82 a0 00 00 00 	lock xchg %eax,0xa0(%edx)
  scheduler();     // start running processes
8010306a:	e8 a1 0c 00 00       	call   80103d10 <scheduler>
8010306f:	90                   	nop

80103070 <mpenter>:
{
80103070:	55                   	push   %ebp
80103071:	89 e5                	mov    %esp,%ebp
80103073:	83 ec 08             	sub    $0x8,%esp
  switchkvm();
80103076:	e8 55 3c 00 00       	call   80106cd0 <switchkvm>
  seginit();
8010307b:	e8 d0 3a 00 00       	call   80106b50 <seginit>
  lapicinit();
80103080:	e8 bb f7 ff ff       	call   80102840 <lapicinit>
  mpmain();
80103085:	e8 a6 ff ff ff       	call   80103030 <mpmain>
8010308a:	66 90                	xchg   %ax,%ax
8010308c:	66 90                	xchg   %ax,%ax
8010308e:	66 90                	xchg   %ax,%ax

80103090 <main>:
{
80103090:	8d 4c 24 04          	lea    0x4(%esp),%ecx
80103094:	83 e4 f0             	and    $0xfffffff0,%esp
80103097:	ff 71 fc             	push   -0x4(%ecx)
8010309a:	55                   	push   %ebp
8010309b:	89 e5                	mov    %esp,%ebp
8010309d:	53                   	push   %ebx
8010309e:	51                   	push   %ecx
  kinit1(end, P2V(4*1024*1024)); // phys page allocator
8010309f:	83 ec 08             	sub    $0x8,%esp
801030a2:	68 00 00 40 80       	push   $0x80400000
801030a7:	68 50 e5 33 80       	push   $0x8033e550
801030ac:	e8 9f f5 ff ff       	call   80102650 <kinit1>
  kvmalloc();      // kernel page table
801030b1:	e8 ca 40 00 00       	call   80107180 <kvmalloc>
  mpinit();        // detect other processors
801030b6:	e8 95 01 00 00       	call   80103250 <mpinit>
  lapicinit();     // interrupt controller
801030bb:	e8 80 f7 ff ff       	call   80102840 <lapicinit>
  seginit();       // segment descriptors
801030c0:	e8 8b 3a 00 00       	call   80106b50 <seginit>
  picinit();       // disable pic
801030c5:	e8 96 03 00 00       	call   80103460 <picinit>
  ioapicinit();    // another interrupt controller
801030ca:	e8 51 f3 ff ff       	call   80102420 <ioapicinit>
  consoleinit();   // console hardware
801030cf:	e8 8c d9 ff ff       	call   80100a60 <consoleinit>
  uartinit();      // serial port
801030d4:	e8 d7 2d 00 00       	call   80105eb0 <uartinit>
  pinit();         // process table
801030d9:	e8 52 08 00 00       	call   80103930 <pinit>
  tvinit();        // trap vectors
801030de:	e8 6d 2a 00 00       	call   80105b50 <tvinit>
  binit();         // buffer cache
801030e3:	e8 58 cf ff ff       	call   80100040 <binit>
  fileinit();      // file table
801030e8:	e8 a3 dd ff ff       	call   80100e90 <fileinit>
  ideinit();       // disk 
801030ed:	e8 0e f1 ff ff       	call   80102200 <ideinit>

  // Write entry code to unused memory at 0x7000.
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);
801030f2:	83 c4 0c             	add    $0xc,%esp
801030f5:	68 8a 00 00 00       	push   $0x8a
801030fa:	68 e4 34 13 80       	push   $0x801334e4
801030ff:	68 00 70 00 80       	push   $0x80007000
80103104:	e8 27 17 00 00       	call   80104830 <memmove>

  for(c = cpus; c < cpus+ncpu; c++){
80103109:	83 c4 10             	add    $0x10,%esp
8010310c:	69 05 e4 a7 13 80 b0 	imul   $0xb0,0x8013a7e4,%eax
80103113:	00 00 00 
80103116:	05 00 a8 13 80       	add    $0x8013a800,%eax
8010311b:	3d 00 a8 13 80       	cmp    $0x8013a800,%eax
80103120:	76 7e                	jbe    801031a0 <main+0x110>
80103122:	bb 00 a8 13 80       	mov    $0x8013a800,%ebx
80103127:	eb 20                	jmp    80103149 <main+0xb9>
80103129:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103130:	69 05 e4 a7 13 80 b0 	imul   $0xb0,0x8013a7e4,%eax
80103137:	00 00 00 
8010313a:	81 c3 b0 00 00 00    	add    $0xb0,%ebx
80103140:	05 00 a8 13 80       	add    $0x8013a800,%eax
80103145:	39 c3                	cmp    %eax,%ebx
80103147:	73 57                	jae    801031a0 <main+0x110>
    if(c == mycpu())  // We've started already.
80103149:	e8 02 08 00 00       	call   80103950 <mycpu>
8010314e:	39 c3                	cmp    %eax,%ebx
80103150:	74 de                	je     80103130 <main+0xa0>
      continue;

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
80103152:	e8 69 f5 ff ff       	call   801026c0 <kalloc>
    *(void**)(code-4) = stack + KSTACKSIZE;
    *(void(**)(void))(code-8) = mpenter;
    *(int**)(code-12) = (void *) V2P(entrypgdir);

    lapicstartap(c->apicid, V2P(code));
80103157:	83 ec 08             	sub    $0x8,%esp
    *(void(**)(void))(code-8) = mpenter;
8010315a:	c7 05 f8 6f 00 80 70 	movl   $0x80103070,0x80006ff8
80103161:	30 10 80 
    *(int**)(code-12) = (void *) V2P(entrypgdir);
80103164:	c7 05 f4 6f 00 80 00 	movl   $0x10a000,0x80006ff4
8010316b:	a0 10 00 
    *(void**)(code-4) = stack + KSTACKSIZE;
8010316e:	05 00 10 00 00       	add    $0x1000,%eax
80103173:	a3 fc 6f 00 80       	mov    %eax,0x80006ffc
    lapicstartap(c->apicid, V2P(code));
80103178:	0f b6 03             	movzbl (%ebx),%eax
8010317b:	68 00 70 00 00       	push   $0x7000
80103180:	50                   	push   %eax
80103181:	e8 fa f7 ff ff       	call   80102980 <lapicstartap>

    // wait for cpu to finish mpmain()
    while(c->started == 0)
80103186:	83 c4 10             	add    $0x10,%esp
80103189:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103190:	8b 83 a0 00 00 00    	mov    0xa0(%ebx),%eax
80103196:	85 c0                	test   %eax,%eax
80103198:	74 f6                	je     80103190 <main+0x100>
8010319a:	eb 94                	jmp    80103130 <main+0xa0>
8010319c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  kinit2(P2V(4*1024*1024), P2V(PHYSTOP)); // must come after startothers()
801031a0:	83 ec 08             	sub    $0x8,%esp
801031a3:	68 00 00 00 8e       	push   $0x8e000000
801031a8:	68 00 00 40 80       	push   $0x80400000
801031ad:	e8 3e f4 ff ff       	call   801025f0 <kinit2>
  shminit();
801031b2:	e8 d9 42 00 00       	call   80107490 <shminit>
  userinit();      // first user process
801031b7:	e8 44 08 00 00       	call   80103a00 <userinit>
  mpmain();        // finish this processor's setup
801031bc:	e8 6f fe ff ff       	call   80103030 <mpmain>
801031c1:	66 90                	xchg   %ax,%ax
801031c3:	66 90                	xchg   %ax,%ax
801031c5:	66 90                	xchg   %ax,%ax
801031c7:	66 90                	xchg   %ax,%ax
801031c9:	66 90                	xchg   %ax,%ax
801031cb:	66 90                	xchg   %ax,%ax
801031cd:	66 90                	xchg   %ax,%ax
801031cf:	90                   	nop

801031d0 <mpsearch1>:
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
801031d0:	55                   	push   %ebp
801031d1:	89 e5                	mov    %esp,%ebp
801031d3:	57                   	push   %edi
801031d4:	56                   	push   %esi
  uchar *e, *p, *addr;

  addr = P2V(a);
801031d5:	8d b0 00 00 00 80    	lea    -0x80000000(%eax),%esi
{
801031db:	53                   	push   %ebx
  e = addr+len;
801031dc:	8d 1c 16             	lea    (%esi,%edx,1),%ebx
{
801031df:	83 ec 0c             	sub    $0xc,%esp
  for(p = addr; p < e; p += sizeof(struct mp))
801031e2:	39 de                	cmp    %ebx,%esi
801031e4:	72 10                	jb     801031f6 <mpsearch1+0x26>
801031e6:	eb 50                	jmp    80103238 <mpsearch1+0x68>
801031e8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801031ef:	00 
801031f0:	89 fe                	mov    %edi,%esi
801031f2:	39 df                	cmp    %ebx,%edi
801031f4:	73 42                	jae    80103238 <mpsearch1+0x68>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
801031f6:	83 ec 04             	sub    $0x4,%esp
801031f9:	8d 7e 10             	lea    0x10(%esi),%edi
801031fc:	6a 04                	push   $0x4
801031fe:	68 8f 84 10 80       	push   $0x8010848f
80103203:	56                   	push   %esi
80103204:	e8 d7 15 00 00       	call   801047e0 <memcmp>
80103209:	83 c4 10             	add    $0x10,%esp
8010320c:	85 c0                	test   %eax,%eax
8010320e:	75 e0                	jne    801031f0 <mpsearch1+0x20>
80103210:	89 f2                	mov    %esi,%edx
80103212:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    sum += addr[i];
80103218:	0f b6 0a             	movzbl (%edx),%ecx
  for(i=0; i<len; i++)
8010321b:	83 c2 01             	add    $0x1,%edx
    sum += addr[i];
8010321e:	01 c8                	add    %ecx,%eax
  for(i=0; i<len; i++)
80103220:	39 fa                	cmp    %edi,%edx
80103222:	75 f4                	jne    80103218 <mpsearch1+0x48>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80103224:	84 c0                	test   %al,%al
80103226:	75 c8                	jne    801031f0 <mpsearch1+0x20>
      return (struct mp*)p;
  return 0;
}
80103228:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010322b:	89 f0                	mov    %esi,%eax
8010322d:	5b                   	pop    %ebx
8010322e:	5e                   	pop    %esi
8010322f:	5f                   	pop    %edi
80103230:	5d                   	pop    %ebp
80103231:	c3                   	ret
80103232:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103238:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
8010323b:	31 f6                	xor    %esi,%esi
}
8010323d:	5b                   	pop    %ebx
8010323e:	89 f0                	mov    %esi,%eax
80103240:	5e                   	pop    %esi
80103241:	5f                   	pop    %edi
80103242:	5d                   	pop    %ebp
80103243:	c3                   	ret
80103244:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010324b:	00 
8010324c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103250 <mpinit>:
  return conf;
}

void
mpinit(void)
{
80103250:	55                   	push   %ebp
80103251:	89 e5                	mov    %esp,%ebp
80103253:	57                   	push   %edi
80103254:	56                   	push   %esi
80103255:	53                   	push   %ebx
80103256:	83 ec 1c             	sub    $0x1c,%esp
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
80103259:	0f b6 05 0f 04 00 80 	movzbl 0x8000040f,%eax
80103260:	0f b6 15 0e 04 00 80 	movzbl 0x8000040e,%edx
80103267:	c1 e0 08             	shl    $0x8,%eax
8010326a:	09 d0                	or     %edx,%eax
8010326c:	c1 e0 04             	shl    $0x4,%eax
8010326f:	75 1b                	jne    8010328c <mpinit+0x3c>
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
80103271:	0f b6 05 14 04 00 80 	movzbl 0x80000414,%eax
80103278:	0f b6 15 13 04 00 80 	movzbl 0x80000413,%edx
8010327f:	c1 e0 08             	shl    $0x8,%eax
80103282:	09 d0                	or     %edx,%eax
80103284:	c1 e0 0a             	shl    $0xa,%eax
    if((mp = mpsearch1(p-1024, 1024)))
80103287:	2d 00 04 00 00       	sub    $0x400,%eax
    if((mp = mpsearch1(p, 1024)))
8010328c:	ba 00 04 00 00       	mov    $0x400,%edx
80103291:	e8 3a ff ff ff       	call   801031d0 <mpsearch1>
80103296:	89 c3                	mov    %eax,%ebx
80103298:	85 c0                	test   %eax,%eax
8010329a:	0f 84 58 01 00 00    	je     801033f8 <mpinit+0x1a8>
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
801032a0:	8b 73 04             	mov    0x4(%ebx),%esi
801032a3:	85 f6                	test   %esi,%esi
801032a5:	0f 84 3d 01 00 00    	je     801033e8 <mpinit+0x198>
  if(memcmp(conf, "PCMP", 4) != 0)
801032ab:	83 ec 04             	sub    $0x4,%esp
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
801032ae:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
801032b4:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(memcmp(conf, "PCMP", 4) != 0)
801032b7:	6a 04                	push   $0x4
801032b9:	68 94 84 10 80       	push   $0x80108494
801032be:	50                   	push   %eax
801032bf:	e8 1c 15 00 00       	call   801047e0 <memcmp>
801032c4:	83 c4 10             	add    $0x10,%esp
801032c7:	85 c0                	test   %eax,%eax
801032c9:	0f 85 19 01 00 00    	jne    801033e8 <mpinit+0x198>
  if(conf->version != 1 && conf->version != 4)
801032cf:	0f b6 86 06 00 00 80 	movzbl -0x7ffffffa(%esi),%eax
801032d6:	3c 01                	cmp    $0x1,%al
801032d8:	74 08                	je     801032e2 <mpinit+0x92>
801032da:	3c 04                	cmp    $0x4,%al
801032dc:	0f 85 06 01 00 00    	jne    801033e8 <mpinit+0x198>
  if(sum((uchar*)conf, conf->length) != 0)
801032e2:	0f b7 96 04 00 00 80 	movzwl -0x7ffffffc(%esi),%edx
  for(i=0; i<len; i++)
801032e9:	66 85 d2             	test   %dx,%dx
801032ec:	74 22                	je     80103310 <mpinit+0xc0>
801032ee:	8d 3c 32             	lea    (%edx,%esi,1),%edi
801032f1:	89 f0                	mov    %esi,%eax
  sum = 0;
801032f3:	31 d2                	xor    %edx,%edx
801032f5:	8d 76 00             	lea    0x0(%esi),%esi
    sum += addr[i];
801032f8:	0f b6 88 00 00 00 80 	movzbl -0x80000000(%eax),%ecx
  for(i=0; i<len; i++)
801032ff:	83 c0 01             	add    $0x1,%eax
    sum += addr[i];
80103302:	01 ca                	add    %ecx,%edx
  for(i=0; i<len; i++)
80103304:	39 f8                	cmp    %edi,%eax
80103306:	75 f0                	jne    801032f8 <mpinit+0xa8>
  if(sum((uchar*)conf, conf->length) != 0)
80103308:	84 d2                	test   %dl,%dl
8010330a:	0f 85 d8 00 00 00    	jne    801033e8 <mpinit+0x198>
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
    panic("Expect to run on an SMP");
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
80103310:	8b 86 24 00 00 80    	mov    -0x7fffffdc(%esi),%eax
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103316:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80103319:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
  lapic = (uint*)conf->lapicaddr;
8010331c:	a3 e0 a6 13 80       	mov    %eax,0x8013a6e0
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103321:	0f b7 96 04 00 00 80 	movzwl -0x7ffffffc(%esi),%edx
80103328:	8d 86 2c 00 00 80    	lea    -0x7fffffd4(%esi),%eax
8010332e:	01 d7                	add    %edx,%edi
80103330:	89 fa                	mov    %edi,%edx
  ismp = 1;
80103332:	bf 01 00 00 00       	mov    $0x1,%edi
80103337:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010333e:	00 
8010333f:	90                   	nop
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103340:	39 d0                	cmp    %edx,%eax
80103342:	73 19                	jae    8010335d <mpinit+0x10d>
    switch(*p){
80103344:	0f b6 08             	movzbl (%eax),%ecx
80103347:	80 f9 02             	cmp    $0x2,%cl
8010334a:	0f 84 80 00 00 00    	je     801033d0 <mpinit+0x180>
80103350:	77 6e                	ja     801033c0 <mpinit+0x170>
80103352:	84 c9                	test   %cl,%cl
80103354:	74 3a                	je     80103390 <mpinit+0x140>
      p += sizeof(struct mpioapic);
      continue;
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
80103356:	83 c0 08             	add    $0x8,%eax
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103359:	39 d0                	cmp    %edx,%eax
8010335b:	72 e7                	jb     80103344 <mpinit+0xf4>
    default:
      ismp = 0;
      break;
    }
  }
  if(!ismp)
8010335d:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80103360:	85 ff                	test   %edi,%edi
80103362:	0f 84 dd 00 00 00    	je     80103445 <mpinit+0x1f5>
    panic("Didn't find a suitable machine");

  if(mp->imcrp){
80103368:	80 7b 0c 00          	cmpb   $0x0,0xc(%ebx)
8010336c:	74 15                	je     80103383 <mpinit+0x133>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010336e:	b8 70 00 00 00       	mov    $0x70,%eax
80103373:	ba 22 00 00 00       	mov    $0x22,%edx
80103378:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103379:	ba 23 00 00 00       	mov    $0x23,%edx
8010337e:	ec                   	in     (%dx),%al
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
8010337f:	83 c8 01             	or     $0x1,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103382:	ee                   	out    %al,(%dx)
  }
}
80103383:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103386:	5b                   	pop    %ebx
80103387:	5e                   	pop    %esi
80103388:	5f                   	pop    %edi
80103389:	5d                   	pop    %ebp
8010338a:	c3                   	ret
8010338b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
      if(ncpu < NCPU) {
80103390:	8b 0d e4 a7 13 80    	mov    0x8013a7e4,%ecx
80103396:	83 f9 07             	cmp    $0x7,%ecx
80103399:	7f 19                	jg     801033b4 <mpinit+0x164>
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
8010339b:	69 f1 b0 00 00 00    	imul   $0xb0,%ecx,%esi
801033a1:	0f b6 58 01          	movzbl 0x1(%eax),%ebx
        ncpu++;
801033a5:	83 c1 01             	add    $0x1,%ecx
801033a8:	89 0d e4 a7 13 80    	mov    %ecx,0x8013a7e4
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
801033ae:	88 9e 00 a8 13 80    	mov    %bl,-0x7fec5800(%esi)
      p += sizeof(struct mpproc);
801033b4:	83 c0 14             	add    $0x14,%eax
      continue;
801033b7:	eb 87                	jmp    80103340 <mpinit+0xf0>
801033b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    switch(*p){
801033c0:	83 e9 03             	sub    $0x3,%ecx
801033c3:	80 f9 01             	cmp    $0x1,%cl
801033c6:	76 8e                	jbe    80103356 <mpinit+0x106>
801033c8:	31 ff                	xor    %edi,%edi
801033ca:	e9 71 ff ff ff       	jmp    80103340 <mpinit+0xf0>
801033cf:	90                   	nop
      ioapicid = ioapic->apicno;
801033d0:	0f b6 48 01          	movzbl 0x1(%eax),%ecx
      p += sizeof(struct mpioapic);
801033d4:	83 c0 08             	add    $0x8,%eax
      ioapicid = ioapic->apicno;
801033d7:	88 0d e0 a7 13 80    	mov    %cl,0x8013a7e0
      continue;
801033dd:	e9 5e ff ff ff       	jmp    80103340 <mpinit+0xf0>
801033e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    panic("Expect to run on an SMP");
801033e8:	83 ec 0c             	sub    $0xc,%esp
801033eb:	68 99 84 10 80       	push   $0x80108499
801033f0:	e8 8b cf ff ff       	call   80100380 <panic>
801033f5:	8d 76 00             	lea    0x0(%esi),%esi
{
801033f8:	bb 00 00 0f 80       	mov    $0x800f0000,%ebx
801033fd:	eb 0b                	jmp    8010340a <mpinit+0x1ba>
801033ff:	90                   	nop
  for(p = addr; p < e; p += sizeof(struct mp))
80103400:	89 f3                	mov    %esi,%ebx
80103402:	81 fe 00 00 10 80    	cmp    $0x80100000,%esi
80103408:	74 de                	je     801033e8 <mpinit+0x198>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
8010340a:	83 ec 04             	sub    $0x4,%esp
8010340d:	8d 73 10             	lea    0x10(%ebx),%esi
80103410:	6a 04                	push   $0x4
80103412:	68 8f 84 10 80       	push   $0x8010848f
80103417:	53                   	push   %ebx
80103418:	e8 c3 13 00 00       	call   801047e0 <memcmp>
8010341d:	83 c4 10             	add    $0x10,%esp
80103420:	85 c0                	test   %eax,%eax
80103422:	75 dc                	jne    80103400 <mpinit+0x1b0>
80103424:	89 da                	mov    %ebx,%edx
80103426:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010342d:	00 
8010342e:	66 90                	xchg   %ax,%ax
    sum += addr[i];
80103430:	0f b6 0a             	movzbl (%edx),%ecx
  for(i=0; i<len; i++)
80103433:	83 c2 01             	add    $0x1,%edx
    sum += addr[i];
80103436:	01 c8                	add    %ecx,%eax
  for(i=0; i<len; i++)
80103438:	39 d6                	cmp    %edx,%esi
8010343a:	75 f4                	jne    80103430 <mpinit+0x1e0>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
8010343c:	84 c0                	test   %al,%al
8010343e:	75 c0                	jne    80103400 <mpinit+0x1b0>
80103440:	e9 5b fe ff ff       	jmp    801032a0 <mpinit+0x50>
    panic("Didn't find a suitable machine");
80103445:	83 ec 0c             	sub    $0xc,%esp
80103448:	68 00 89 10 80       	push   $0x80108900
8010344d:	e8 2e cf ff ff       	call   80100380 <panic>
80103452:	66 90                	xchg   %ax,%ax
80103454:	66 90                	xchg   %ax,%ax
80103456:	66 90                	xchg   %ax,%ax
80103458:	66 90                	xchg   %ax,%ax
8010345a:	66 90                	xchg   %ax,%ax
8010345c:	66 90                	xchg   %ax,%ax
8010345e:	66 90                	xchg   %ax,%ax

80103460 <picinit>:
80103460:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103465:	ba 21 00 00 00       	mov    $0x21,%edx
8010346a:	ee                   	out    %al,(%dx)
8010346b:	ba a1 00 00 00       	mov    $0xa1,%edx
80103470:	ee                   	out    %al,(%dx)
picinit(void)
{
  // mask all interrupts
  outb(IO_PIC1+1, 0xFF);
  outb(IO_PIC2+1, 0xFF);
}
80103471:	c3                   	ret
80103472:	66 90                	xchg   %ax,%ax
80103474:	66 90                	xchg   %ax,%ax
80103476:	66 90                	xchg   %ax,%ax
80103478:	66 90                	xchg   %ax,%ax
8010347a:	66 90                	xchg   %ax,%ax
8010347c:	66 90                	xchg   %ax,%ax
8010347e:	66 90                	xchg   %ax,%ax

80103480 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
80103480:	55                   	push   %ebp
80103481:	89 e5                	mov    %esp,%ebp
80103483:	57                   	push   %edi
80103484:	56                   	push   %esi
80103485:	53                   	push   %ebx
80103486:	83 ec 0c             	sub    $0xc,%esp
80103489:	8b 75 08             	mov    0x8(%ebp),%esi
8010348c:	8b 7d 0c             	mov    0xc(%ebp),%edi
  struct pipe *p;

  p = 0;
  *f0 = *f1 = 0;
8010348f:	c7 07 00 00 00 00    	movl   $0x0,(%edi)
80103495:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
8010349b:	e8 10 da ff ff       	call   80100eb0 <filealloc>
801034a0:	89 06                	mov    %eax,(%esi)
801034a2:	85 c0                	test   %eax,%eax
801034a4:	0f 84 a5 00 00 00    	je     8010354f <pipealloc+0xcf>
801034aa:	e8 01 da ff ff       	call   80100eb0 <filealloc>
801034af:	89 07                	mov    %eax,(%edi)
801034b1:	85 c0                	test   %eax,%eax
801034b3:	0f 84 84 00 00 00    	je     8010353d <pipealloc+0xbd>
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
801034b9:	e8 02 f2 ff ff       	call   801026c0 <kalloc>
801034be:	89 c3                	mov    %eax,%ebx
801034c0:	85 c0                	test   %eax,%eax
801034c2:	0f 84 a0 00 00 00    	je     80103568 <pipealloc+0xe8>
    goto bad;
  p->readopen = 1;
801034c8:	c7 80 3c 02 00 00 01 	movl   $0x1,0x23c(%eax)
801034cf:	00 00 00 
  p->writeopen = 1;
  p->nwrite = 0;
  p->nread = 0;
  initlock(&p->lock, "pipe");
801034d2:	83 ec 08             	sub    $0x8,%esp
  p->writeopen = 1;
801034d5:	c7 80 40 02 00 00 01 	movl   $0x1,0x240(%eax)
801034dc:	00 00 00 
  p->nwrite = 0;
801034df:	c7 80 38 02 00 00 00 	movl   $0x0,0x238(%eax)
801034e6:	00 00 00 
  p->nread = 0;
801034e9:	c7 80 34 02 00 00 00 	movl   $0x0,0x234(%eax)
801034f0:	00 00 00 
  initlock(&p->lock, "pipe");
801034f3:	68 b1 84 10 80       	push   $0x801084b1
801034f8:	50                   	push   %eax
801034f9:	e8 b2 0f 00 00       	call   801044b0 <initlock>
  (*f0)->type = FD_PIPE;
801034fe:	8b 06                	mov    (%esi),%eax
  (*f0)->pipe = p;
  (*f1)->type = FD_PIPE;
  (*f1)->readable = 0;
  (*f1)->writable = 1;
  (*f1)->pipe = p;
  return 0;
80103500:	83 c4 10             	add    $0x10,%esp
  (*f0)->type = FD_PIPE;
80103503:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f0)->readable = 1;
80103509:	8b 06                	mov    (%esi),%eax
8010350b:	c6 40 08 01          	movb   $0x1,0x8(%eax)
  (*f0)->writable = 0;
8010350f:	8b 06                	mov    (%esi),%eax
80103511:	c6 40 09 00          	movb   $0x0,0x9(%eax)
  (*f0)->pipe = p;
80103515:	8b 06                	mov    (%esi),%eax
80103517:	89 58 0c             	mov    %ebx,0xc(%eax)
  (*f1)->type = FD_PIPE;
8010351a:	8b 07                	mov    (%edi),%eax
8010351c:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f1)->readable = 0;
80103522:	8b 07                	mov    (%edi),%eax
80103524:	c6 40 08 00          	movb   $0x0,0x8(%eax)
  (*f1)->writable = 1;
80103528:	8b 07                	mov    (%edi),%eax
8010352a:	c6 40 09 01          	movb   $0x1,0x9(%eax)
  (*f1)->pipe = p;
8010352e:	8b 07                	mov    (%edi),%eax
80103530:	89 58 0c             	mov    %ebx,0xc(%eax)
  return 0;
80103533:	31 c0                	xor    %eax,%eax
  if(*f0)
    fileclose(*f0);
  if(*f1)
    fileclose(*f1);
  return -1;
}
80103535:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103538:	5b                   	pop    %ebx
80103539:	5e                   	pop    %esi
8010353a:	5f                   	pop    %edi
8010353b:	5d                   	pop    %ebp
8010353c:	c3                   	ret
  if(*f0)
8010353d:	8b 06                	mov    (%esi),%eax
8010353f:	85 c0                	test   %eax,%eax
80103541:	74 1e                	je     80103561 <pipealloc+0xe1>
    fileclose(*f0);
80103543:	83 ec 0c             	sub    $0xc,%esp
80103546:	50                   	push   %eax
80103547:	e8 24 da ff ff       	call   80100f70 <fileclose>
8010354c:	83 c4 10             	add    $0x10,%esp
  if(*f1)
8010354f:	8b 07                	mov    (%edi),%eax
80103551:	85 c0                	test   %eax,%eax
80103553:	74 0c                	je     80103561 <pipealloc+0xe1>
    fileclose(*f1);
80103555:	83 ec 0c             	sub    $0xc,%esp
80103558:	50                   	push   %eax
80103559:	e8 12 da ff ff       	call   80100f70 <fileclose>
8010355e:	83 c4 10             	add    $0x10,%esp
  return -1;
80103561:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103566:	eb cd                	jmp    80103535 <pipealloc+0xb5>
  if(*f0)
80103568:	8b 06                	mov    (%esi),%eax
8010356a:	85 c0                	test   %eax,%eax
8010356c:	75 d5                	jne    80103543 <pipealloc+0xc3>
8010356e:	eb df                	jmp    8010354f <pipealloc+0xcf>

80103570 <pipeclose>:

void
pipeclose(struct pipe *p, int writable)
{
80103570:	55                   	push   %ebp
80103571:	89 e5                	mov    %esp,%ebp
80103573:	56                   	push   %esi
80103574:	53                   	push   %ebx
80103575:	8b 5d 08             	mov    0x8(%ebp),%ebx
80103578:	8b 75 0c             	mov    0xc(%ebp),%esi
  acquire(&p->lock);
8010357b:	83 ec 0c             	sub    $0xc,%esp
8010357e:	53                   	push   %ebx
8010357f:	e8 1c 11 00 00       	call   801046a0 <acquire>
  if(writable){
80103584:	83 c4 10             	add    $0x10,%esp
80103587:	85 f6                	test   %esi,%esi
80103589:	74 65                	je     801035f0 <pipeclose+0x80>
    p->writeopen = 0;
    wakeup(&p->nread);
8010358b:	83 ec 0c             	sub    $0xc,%esp
8010358e:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
    p->writeopen = 0;
80103594:	c7 83 40 02 00 00 00 	movl   $0x0,0x240(%ebx)
8010359b:	00 00 00 
    wakeup(&p->nread);
8010359e:	50                   	push   %eax
8010359f:	e8 3c 0c 00 00       	call   801041e0 <wakeup>
801035a4:	83 c4 10             	add    $0x10,%esp
  } else {
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0){
801035a7:	8b 93 3c 02 00 00    	mov    0x23c(%ebx),%edx
801035ad:	85 d2                	test   %edx,%edx
801035af:	75 0a                	jne    801035bb <pipeclose+0x4b>
801035b1:	8b 83 40 02 00 00    	mov    0x240(%ebx),%eax
801035b7:	85 c0                	test   %eax,%eax
801035b9:	74 15                	je     801035d0 <pipeclose+0x60>
    release(&p->lock);
    kfree((char*)p);
  } else
    release(&p->lock);
801035bb:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
801035be:	8d 65 f8             	lea    -0x8(%ebp),%esp
801035c1:	5b                   	pop    %ebx
801035c2:	5e                   	pop    %esi
801035c3:	5d                   	pop    %ebp
    release(&p->lock);
801035c4:	e9 77 10 00 00       	jmp    80104640 <release>
801035c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    release(&p->lock);
801035d0:	83 ec 0c             	sub    $0xc,%esp
801035d3:	53                   	push   %ebx
801035d4:	e8 67 10 00 00       	call   80104640 <release>
    kfree((char*)p);
801035d9:	83 c4 10             	add    $0x10,%esp
801035dc:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
801035df:	8d 65 f8             	lea    -0x8(%ebp),%esp
801035e2:	5b                   	pop    %ebx
801035e3:	5e                   	pop    %esi
801035e4:	5d                   	pop    %ebp
    kfree((char*)p);
801035e5:	e9 16 ef ff ff       	jmp    80102500 <kfree>
801035ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    wakeup(&p->nwrite);
801035f0:	83 ec 0c             	sub    $0xc,%esp
801035f3:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
    p->readopen = 0;
801035f9:	c7 83 3c 02 00 00 00 	movl   $0x0,0x23c(%ebx)
80103600:	00 00 00 
    wakeup(&p->nwrite);
80103603:	50                   	push   %eax
80103604:	e8 d7 0b 00 00       	call   801041e0 <wakeup>
80103609:	83 c4 10             	add    $0x10,%esp
8010360c:	eb 99                	jmp    801035a7 <pipeclose+0x37>
8010360e:	66 90                	xchg   %ax,%ax

80103610 <pipewrite>:

//PAGEBREAK: 40
int
pipewrite(struct pipe *p, char *addr, int n)
{
80103610:	55                   	push   %ebp
80103611:	89 e5                	mov    %esp,%ebp
80103613:	57                   	push   %edi
80103614:	56                   	push   %esi
80103615:	53                   	push   %ebx
80103616:	83 ec 28             	sub    $0x28,%esp
80103619:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010361c:	8b 7d 10             	mov    0x10(%ebp),%edi
  int i;

  acquire(&p->lock);
8010361f:	53                   	push   %ebx
80103620:	e8 7b 10 00 00       	call   801046a0 <acquire>
  for(i = 0; i < n; i++){
80103625:	83 c4 10             	add    $0x10,%esp
80103628:	85 ff                	test   %edi,%edi
8010362a:	0f 8e ce 00 00 00    	jle    801036fe <pipewrite+0xee>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103630:	8b 83 38 02 00 00    	mov    0x238(%ebx),%eax
80103636:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80103639:	89 7d 10             	mov    %edi,0x10(%ebp)
8010363c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
8010363f:	8d 34 39             	lea    (%ecx,%edi,1),%esi
80103642:	89 75 e0             	mov    %esi,-0x20(%ebp)
      if(p->readopen == 0 || myproc()->killed){
        release(&p->lock);
        return -1;
      }
      wakeup(&p->nread);
80103645:	8d b3 34 02 00 00    	lea    0x234(%ebx),%esi
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
8010364b:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
80103651:	8d bb 38 02 00 00    	lea    0x238(%ebx),%edi
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103657:	8d 90 00 02 00 00    	lea    0x200(%eax),%edx
8010365d:	39 55 e4             	cmp    %edx,-0x1c(%ebp)
80103660:	0f 85 b6 00 00 00    	jne    8010371c <pipewrite+0x10c>
80103666:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80103669:	eb 3b                	jmp    801036a6 <pipewrite+0x96>
8010366b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
      if(p->readopen == 0 || myproc()->killed){
80103670:	e8 5b 03 00 00       	call   801039d0 <myproc>
80103675:	8b 48 24             	mov    0x24(%eax),%ecx
80103678:	85 c9                	test   %ecx,%ecx
8010367a:	75 34                	jne    801036b0 <pipewrite+0xa0>
      wakeup(&p->nread);
8010367c:	83 ec 0c             	sub    $0xc,%esp
8010367f:	56                   	push   %esi
80103680:	e8 5b 0b 00 00       	call   801041e0 <wakeup>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
80103685:	58                   	pop    %eax
80103686:	5a                   	pop    %edx
80103687:	53                   	push   %ebx
80103688:	57                   	push   %edi
80103689:	e8 92 0a 00 00       	call   80104120 <sleep>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
8010368e:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
80103694:	8b 93 38 02 00 00    	mov    0x238(%ebx),%edx
8010369a:	83 c4 10             	add    $0x10,%esp
8010369d:	05 00 02 00 00       	add    $0x200,%eax
801036a2:	39 c2                	cmp    %eax,%edx
801036a4:	75 2a                	jne    801036d0 <pipewrite+0xc0>
      if(p->readopen == 0 || myproc()->killed){
801036a6:	8b 83 3c 02 00 00    	mov    0x23c(%ebx),%eax
801036ac:	85 c0                	test   %eax,%eax
801036ae:	75 c0                	jne    80103670 <pipewrite+0x60>
        release(&p->lock);
801036b0:	83 ec 0c             	sub    $0xc,%esp
801036b3:	53                   	push   %ebx
801036b4:	e8 87 0f 00 00       	call   80104640 <release>
        return -1;
801036b9:	83 c4 10             	add    $0x10,%esp
801036bc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
  release(&p->lock);
  return n;
}
801036c1:	8d 65 f4             	lea    -0xc(%ebp),%esp
801036c4:	5b                   	pop    %ebx
801036c5:	5e                   	pop    %esi
801036c6:	5f                   	pop    %edi
801036c7:	5d                   	pop    %ebp
801036c8:	c3                   	ret
801036c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801036d0:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
801036d3:	8d 42 01             	lea    0x1(%edx),%eax
801036d6:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
  for(i = 0; i < n; i++){
801036dc:	83 c1 01             	add    $0x1,%ecx
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
801036df:	89 83 38 02 00 00    	mov    %eax,0x238(%ebx)
801036e5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801036e8:	0f b6 41 ff          	movzbl -0x1(%ecx),%eax
801036ec:	88 44 13 34          	mov    %al,0x34(%ebx,%edx,1)
  for(i = 0; i < n; i++){
801036f0:	8b 45 e0             	mov    -0x20(%ebp),%eax
801036f3:	39 c1                	cmp    %eax,%ecx
801036f5:	0f 85 50 ff ff ff    	jne    8010364b <pipewrite+0x3b>
801036fb:	8b 7d 10             	mov    0x10(%ebp),%edi
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
801036fe:	83 ec 0c             	sub    $0xc,%esp
80103701:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
80103707:	50                   	push   %eax
80103708:	e8 d3 0a 00 00       	call   801041e0 <wakeup>
  release(&p->lock);
8010370d:	89 1c 24             	mov    %ebx,(%esp)
80103710:	e8 2b 0f 00 00       	call   80104640 <release>
  return n;
80103715:	83 c4 10             	add    $0x10,%esp
80103718:	89 f8                	mov    %edi,%eax
8010371a:	eb a5                	jmp    801036c1 <pipewrite+0xb1>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
8010371c:	8b 55 e4             	mov    -0x1c(%ebp),%edx
8010371f:	eb b2                	jmp    801036d3 <pipewrite+0xc3>
80103721:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103728:	00 
80103729:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103730 <piperead>:

int
piperead(struct pipe *p, char *addr, int n)
{
80103730:	55                   	push   %ebp
80103731:	89 e5                	mov    %esp,%ebp
80103733:	57                   	push   %edi
80103734:	56                   	push   %esi
80103735:	53                   	push   %ebx
80103736:	83 ec 18             	sub    $0x18,%esp
80103739:	8b 75 08             	mov    0x8(%ebp),%esi
8010373c:	8b 7d 0c             	mov    0xc(%ebp),%edi
  int i;

  acquire(&p->lock);
8010373f:	56                   	push   %esi
80103740:	8d 9e 34 02 00 00    	lea    0x234(%esi),%ebx
80103746:	e8 55 0f 00 00       	call   801046a0 <acquire>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
8010374b:	8b 86 34 02 00 00    	mov    0x234(%esi),%eax
80103751:	83 c4 10             	add    $0x10,%esp
80103754:	3b 86 38 02 00 00    	cmp    0x238(%esi),%eax
8010375a:	74 2f                	je     8010378b <piperead+0x5b>
8010375c:	eb 37                	jmp    80103795 <piperead+0x65>
8010375e:	66 90                	xchg   %ax,%ax
    if(myproc()->killed){
80103760:	e8 6b 02 00 00       	call   801039d0 <myproc>
80103765:	8b 40 24             	mov    0x24(%eax),%eax
80103768:	85 c0                	test   %eax,%eax
8010376a:	0f 85 80 00 00 00    	jne    801037f0 <piperead+0xc0>
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
80103770:	83 ec 08             	sub    $0x8,%esp
80103773:	56                   	push   %esi
80103774:	53                   	push   %ebx
80103775:	e8 a6 09 00 00       	call   80104120 <sleep>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
8010377a:	8b 86 34 02 00 00    	mov    0x234(%esi),%eax
80103780:	83 c4 10             	add    $0x10,%esp
80103783:	3b 86 38 02 00 00    	cmp    0x238(%esi),%eax
80103789:	75 0a                	jne    80103795 <piperead+0x65>
8010378b:	8b 96 40 02 00 00    	mov    0x240(%esi),%edx
80103791:	85 d2                	test   %edx,%edx
80103793:	75 cb                	jne    80103760 <piperead+0x30>
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80103795:	8b 4d 10             	mov    0x10(%ebp),%ecx
80103798:	31 db                	xor    %ebx,%ebx
8010379a:	85 c9                	test   %ecx,%ecx
8010379c:	7f 26                	jg     801037c4 <piperead+0x94>
8010379e:	eb 2c                	jmp    801037cc <piperead+0x9c>
    if(p->nread == p->nwrite)
      break;
    addr[i] = p->data[p->nread++ % PIPESIZE];
801037a0:	8d 48 01             	lea    0x1(%eax),%ecx
801037a3:	25 ff 01 00 00       	and    $0x1ff,%eax
801037a8:	89 8e 34 02 00 00    	mov    %ecx,0x234(%esi)
801037ae:	0f b6 44 06 34       	movzbl 0x34(%esi,%eax,1),%eax
801037b3:	88 04 1f             	mov    %al,(%edi,%ebx,1)
  for(i = 0; i < n; i++){  //DOC: piperead-copy
801037b6:	83 c3 01             	add    $0x1,%ebx
801037b9:	39 5d 10             	cmp    %ebx,0x10(%ebp)
801037bc:	74 0e                	je     801037cc <piperead+0x9c>
801037be:	8b 86 34 02 00 00    	mov    0x234(%esi),%eax
    if(p->nread == p->nwrite)
801037c4:	3b 86 38 02 00 00    	cmp    0x238(%esi),%eax
801037ca:	75 d4                	jne    801037a0 <piperead+0x70>
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
801037cc:	83 ec 0c             	sub    $0xc,%esp
801037cf:	8d 86 38 02 00 00    	lea    0x238(%esi),%eax
801037d5:	50                   	push   %eax
801037d6:	e8 05 0a 00 00       	call   801041e0 <wakeup>
  release(&p->lock);
801037db:	89 34 24             	mov    %esi,(%esp)
801037de:	e8 5d 0e 00 00       	call   80104640 <release>
  return i;
801037e3:	83 c4 10             	add    $0x10,%esp
}
801037e6:	8d 65 f4             	lea    -0xc(%ebp),%esp
801037e9:	89 d8                	mov    %ebx,%eax
801037eb:	5b                   	pop    %ebx
801037ec:	5e                   	pop    %esi
801037ed:	5f                   	pop    %edi
801037ee:	5d                   	pop    %ebp
801037ef:	c3                   	ret
      release(&p->lock);
801037f0:	83 ec 0c             	sub    $0xc,%esp
      return -1;
801037f3:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
      release(&p->lock);
801037f8:	56                   	push   %esi
801037f9:	e8 42 0e 00 00       	call   80104640 <release>
      return -1;
801037fe:	83 c4 10             	add    $0x10,%esp
}
80103801:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103804:	89 d8                	mov    %ebx,%eax
80103806:	5b                   	pop    %ebx
80103807:	5e                   	pop    %esi
80103808:	5f                   	pop    %edi
80103809:	5d                   	pop    %ebp
8010380a:	c3                   	ret
8010380b:	66 90                	xchg   %ax,%ax
8010380d:	66 90                	xchg   %ax,%ax
8010380f:	90                   	nop

80103810 <allocproc>:
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
80103810:	55                   	push   %ebp
80103811:	89 e5                	mov    %esp,%ebp
80103813:	53                   	push   %ebx
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103814:	bb b4 ad 13 80       	mov    $0x8013adb4,%ebx
{
80103819:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);
8010381c:	68 80 ad 13 80       	push   $0x8013ad80
80103821:	e8 7a 0e 00 00       	call   801046a0 <acquire>
80103826:	83 c4 10             	add    $0x10,%esp
80103829:	eb 13                	jmp    8010383e <allocproc+0x2e>
8010382b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103830:	81 c3 7c 80 00 00    	add    $0x807c,%ebx
80103836:	81 fb b4 cc 33 80    	cmp    $0x8033ccb4,%ebx
8010383c:	74 7a                	je     801038b8 <allocproc+0xa8>
    if(p->state == UNUSED)
8010383e:	8b 43 0c             	mov    0xc(%ebx),%eax
80103841:	85 c0                	test   %eax,%eax
80103843:	75 eb                	jne    80103830 <allocproc+0x20>
  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
  p->pid = nextpid++;
80103845:	a1 04 b0 10 80       	mov    0x8010b004,%eax

  release(&ptable.lock);
8010384a:	83 ec 0c             	sub    $0xc,%esp
  p->state = EMBRYO;
8010384d:	c7 43 0c 01 00 00 00 	movl   $0x1,0xc(%ebx)
  p->pid = nextpid++;
80103854:	89 43 10             	mov    %eax,0x10(%ebx)
80103857:	8d 50 01             	lea    0x1(%eax),%edx
  release(&ptable.lock);
8010385a:	68 80 ad 13 80       	push   $0x8013ad80
  p->pid = nextpid++;
8010385f:	89 15 04 b0 10 80    	mov    %edx,0x8010b004
  release(&ptable.lock);
80103865:	e8 d6 0d 00 00       	call   80104640 <release>

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
8010386a:	e8 51 ee ff ff       	call   801026c0 <kalloc>
8010386f:	83 c4 10             	add    $0x10,%esp
80103872:	89 43 08             	mov    %eax,0x8(%ebx)
80103875:	85 c0                	test   %eax,%eax
80103877:	74 58                	je     801038d1 <allocproc+0xc1>
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
80103879:	8d 90 b4 0f 00 00    	lea    0xfb4(%eax),%edx
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
8010387f:	83 ec 04             	sub    $0x4,%esp
  sp -= sizeof *p->context;
80103882:	05 9c 0f 00 00       	add    $0xf9c,%eax
  sp -= sizeof *p->tf;
80103887:	89 53 18             	mov    %edx,0x18(%ebx)
  *(uint*)sp = (uint)trapret;
8010388a:	c7 40 14 42 5b 10 80 	movl   $0x80105b42,0x14(%eax)
  p->context = (struct context*)sp;
80103891:	89 43 1c             	mov    %eax,0x1c(%ebx)
  memset(p->context, 0, sizeof *p->context);
80103894:	6a 14                	push   $0x14
80103896:	6a 00                	push   $0x0
80103898:	50                   	push   %eax
80103899:	e8 02 0f 00 00       	call   801047a0 <memset>
  p->context->eip = (uint)forkret;
8010389e:	8b 43 1c             	mov    0x1c(%ebx),%eax

  return p;
801038a1:	83 c4 10             	add    $0x10,%esp
  p->context->eip = (uint)forkret;
801038a4:	c7 40 10 e0 38 10 80 	movl   $0x801038e0,0x10(%eax)
}
801038ab:	89 d8                	mov    %ebx,%eax
801038ad:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801038b0:	c9                   	leave
801038b1:	c3                   	ret
801038b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  release(&ptable.lock);
801038b8:	83 ec 0c             	sub    $0xc,%esp
  return 0;
801038bb:	31 db                	xor    %ebx,%ebx
  release(&ptable.lock);
801038bd:	68 80 ad 13 80       	push   $0x8013ad80
801038c2:	e8 79 0d 00 00       	call   80104640 <release>
  return 0;
801038c7:	83 c4 10             	add    $0x10,%esp
}
801038ca:	89 d8                	mov    %ebx,%eax
801038cc:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801038cf:	c9                   	leave
801038d0:	c3                   	ret
    p->state = UNUSED;
801038d1:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  return 0;
801038d8:	31 db                	xor    %ebx,%ebx
801038da:	eb ee                	jmp    801038ca <allocproc+0xba>
801038dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801038e0 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
801038e0:	55                   	push   %ebp
801038e1:	89 e5                	mov    %esp,%ebp
801038e3:	83 ec 14             	sub    $0x14,%esp
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);
801038e6:	68 80 ad 13 80       	push   $0x8013ad80
801038eb:	e8 50 0d 00 00       	call   80104640 <release>

  if (first) {
801038f0:	a1 00 b0 10 80       	mov    0x8010b000,%eax
801038f5:	83 c4 10             	add    $0x10,%esp
801038f8:	85 c0                	test   %eax,%eax
801038fa:	75 04                	jne    80103900 <forkret+0x20>
    iinit(ROOTDEV);
    initlog(ROOTDEV);
  }

  // Return to "caller", actually trapret (see allocproc).
}
801038fc:	c9                   	leave
801038fd:	c3                   	ret
801038fe:	66 90                	xchg   %ax,%ax
    first = 0;
80103900:	c7 05 00 b0 10 80 00 	movl   $0x0,0x8010b000
80103907:	00 00 00 
    iinit(ROOTDEV);
8010390a:	83 ec 0c             	sub    $0xc,%esp
8010390d:	6a 01                	push   $0x1
8010390f:	e8 cc dc ff ff       	call   801015e0 <iinit>
    initlog(ROOTDEV);
80103914:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
8010391b:	e8 e0 f3 ff ff       	call   80102d00 <initlog>
}
80103920:	83 c4 10             	add    $0x10,%esp
80103923:	c9                   	leave
80103924:	c3                   	ret
80103925:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010392c:	00 
8010392d:	8d 76 00             	lea    0x0(%esi),%esi

80103930 <pinit>:
{
80103930:	55                   	push   %ebp
80103931:	89 e5                	mov    %esp,%ebp
80103933:	83 ec 10             	sub    $0x10,%esp
  initlock(&ptable.lock, "ptable");
80103936:	68 b6 84 10 80       	push   $0x801084b6
8010393b:	68 80 ad 13 80       	push   $0x8013ad80
80103940:	e8 6b 0b 00 00       	call   801044b0 <initlock>
}
80103945:	83 c4 10             	add    $0x10,%esp
80103948:	c9                   	leave
80103949:	c3                   	ret
8010394a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103950 <mycpu>:
{
80103950:	55                   	push   %ebp
80103951:	89 e5                	mov    %esp,%ebp
80103953:	56                   	push   %esi
80103954:	53                   	push   %ebx
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103955:	9c                   	pushf
80103956:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80103957:	f6 c4 02             	test   $0x2,%ah
8010395a:	75 46                	jne    801039a2 <mycpu+0x52>
  apicid = lapicid();
8010395c:	e8 cf ef ff ff       	call   80102930 <lapicid>
  for (i = 0; i < ncpu; ++i) {
80103961:	8b 35 e4 a7 13 80    	mov    0x8013a7e4,%esi
80103967:	85 f6                	test   %esi,%esi
80103969:	7e 2a                	jle    80103995 <mycpu+0x45>
8010396b:	31 d2                	xor    %edx,%edx
8010396d:	eb 08                	jmp    80103977 <mycpu+0x27>
8010396f:	90                   	nop
80103970:	83 c2 01             	add    $0x1,%edx
80103973:	39 f2                	cmp    %esi,%edx
80103975:	74 1e                	je     80103995 <mycpu+0x45>
    if (cpus[i].apicid == apicid)
80103977:	69 ca b0 00 00 00    	imul   $0xb0,%edx,%ecx
8010397d:	0f b6 99 00 a8 13 80 	movzbl -0x7fec5800(%ecx),%ebx
80103984:	39 c3                	cmp    %eax,%ebx
80103986:	75 e8                	jne    80103970 <mycpu+0x20>
}
80103988:	8d 65 f8             	lea    -0x8(%ebp),%esp
      return &cpus[i];
8010398b:	8d 81 00 a8 13 80    	lea    -0x7fec5800(%ecx),%eax
}
80103991:	5b                   	pop    %ebx
80103992:	5e                   	pop    %esi
80103993:	5d                   	pop    %ebp
80103994:	c3                   	ret
  panic("unknown apicid\n");
80103995:	83 ec 0c             	sub    $0xc,%esp
80103998:	68 bd 84 10 80       	push   $0x801084bd
8010399d:	e8 de c9 ff ff       	call   80100380 <panic>
    panic("mycpu called with interrupts enabled\n");
801039a2:	83 ec 0c             	sub    $0xc,%esp
801039a5:	68 20 89 10 80       	push   $0x80108920
801039aa:	e8 d1 c9 ff ff       	call   80100380 <panic>
801039af:	90                   	nop

801039b0 <cpuid>:
cpuid() {
801039b0:	55                   	push   %ebp
801039b1:	89 e5                	mov    %esp,%ebp
801039b3:	83 ec 08             	sub    $0x8,%esp
  return mycpu()-cpus;
801039b6:	e8 95 ff ff ff       	call   80103950 <mycpu>
}
801039bb:	c9                   	leave
  return mycpu()-cpus;
801039bc:	2d 00 a8 13 80       	sub    $0x8013a800,%eax
801039c1:	c1 f8 04             	sar    $0x4,%eax
801039c4:	69 c0 a3 8b 2e ba    	imul   $0xba2e8ba3,%eax,%eax
}
801039ca:	c3                   	ret
801039cb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

801039d0 <myproc>:
myproc(void) {
801039d0:	55                   	push   %ebp
801039d1:	89 e5                	mov    %esp,%ebp
801039d3:	53                   	push   %ebx
801039d4:	83 ec 04             	sub    $0x4,%esp
  pushcli();
801039d7:	e8 74 0b 00 00       	call   80104550 <pushcli>
  c = mycpu();
801039dc:	e8 6f ff ff ff       	call   80103950 <mycpu>
  p = c->proc;
801039e1:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801039e7:	e8 b4 0b 00 00       	call   801045a0 <popcli>
}
801039ec:	89 d8                	mov    %ebx,%eax
801039ee:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801039f1:	c9                   	leave
801039f2:	c3                   	ret
801039f3:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801039fa:	00 
801039fb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80103a00 <userinit>:
{
80103a00:	55                   	push   %ebp
80103a01:	89 e5                	mov    %esp,%ebp
80103a03:	53                   	push   %ebx
80103a04:	83 ec 04             	sub    $0x4,%esp
  p = allocproc();
80103a07:	e8 04 fe ff ff       	call   80103810 <allocproc>
80103a0c:	89 c3                	mov    %eax,%ebx
  initproc = p;
80103a0e:	a3 b4 cc 33 80       	mov    %eax,0x8033ccb4
  if((p->pgdir = setupkvm()) == 0)
80103a13:	e8 e8 36 00 00       	call   80107100 <setupkvm>
80103a18:	89 43 04             	mov    %eax,0x4(%ebx)
80103a1b:	85 c0                	test   %eax,%eax
80103a1d:	0f 84 bd 00 00 00    	je     80103ae0 <userinit+0xe0>
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
80103a23:	83 ec 04             	sub    $0x4,%esp
80103a26:	68 2c 00 00 00       	push   $0x2c
80103a2b:	68 b8 34 13 80       	push   $0x801334b8
80103a30:	50                   	push   %eax
80103a31:	e8 ba 33 00 00       	call   80106df0 <inituvm>
  memset(p->tf, 0, sizeof(*p->tf));
80103a36:	83 c4 0c             	add    $0xc,%esp
  p->sz = PGSIZE;
80103a39:	c7 03 00 10 00 00    	movl   $0x1000,(%ebx)
  memset(p->tf, 0, sizeof(*p->tf));
80103a3f:	6a 4c                	push   $0x4c
80103a41:	6a 00                	push   $0x0
80103a43:	ff 73 18             	push   0x18(%ebx)
80103a46:	e8 55 0d 00 00       	call   801047a0 <memset>
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
80103a4b:	8b 43 18             	mov    0x18(%ebx),%eax
80103a4e:	ba 1b 00 00 00       	mov    $0x1b,%edx
  safestrcpy(p->name, "initcode", sizeof(p->name));
80103a53:	83 c4 0c             	add    $0xc,%esp
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80103a56:	b9 23 00 00 00       	mov    $0x23,%ecx
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
80103a5b:	66 89 50 3c          	mov    %dx,0x3c(%eax)
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80103a5f:	8b 43 18             	mov    0x18(%ebx),%eax
80103a62:	66 89 48 2c          	mov    %cx,0x2c(%eax)
  p->tf->es = p->tf->ds;
80103a66:	8b 43 18             	mov    0x18(%ebx),%eax
80103a69:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
80103a6d:	66 89 50 28          	mov    %dx,0x28(%eax)
  p->tf->ss = p->tf->ds;
80103a71:	8b 43 18             	mov    0x18(%ebx),%eax
80103a74:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
80103a78:	66 89 50 48          	mov    %dx,0x48(%eax)
  p->tf->eflags = FL_IF;
80103a7c:	8b 43 18             	mov    0x18(%ebx),%eax
80103a7f:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  p->tf->esp = PGSIZE;
80103a86:	8b 43 18             	mov    0x18(%ebx),%eax
80103a89:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  p->tf->eip = 0;  // beginning of initcode.S
80103a90:	8b 43 18             	mov    0x18(%ebx),%eax
80103a93:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)
  safestrcpy(p->name, "initcode", sizeof(p->name));
80103a9a:	8d 43 6c             	lea    0x6c(%ebx),%eax
80103a9d:	6a 10                	push   $0x10
80103a9f:	68 e6 84 10 80       	push   $0x801084e6
80103aa4:	50                   	push   %eax
80103aa5:	e8 a6 0e 00 00       	call   80104950 <safestrcpy>
  p->cwd = namei("/");
80103aaa:	c7 04 24 ef 84 10 80 	movl   $0x801084ef,(%esp)
80103ab1:	e8 2a e6 ff ff       	call   801020e0 <namei>
80103ab6:	89 43 68             	mov    %eax,0x68(%ebx)
  acquire(&ptable.lock);
80103ab9:	c7 04 24 80 ad 13 80 	movl   $0x8013ad80,(%esp)
80103ac0:	e8 db 0b 00 00       	call   801046a0 <acquire>
  p->state = RUNNABLE;
80103ac5:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  release(&ptable.lock);
80103acc:	c7 04 24 80 ad 13 80 	movl   $0x8013ad80,(%esp)
80103ad3:	e8 68 0b 00 00       	call   80104640 <release>
}
80103ad8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103adb:	83 c4 10             	add    $0x10,%esp
80103ade:	c9                   	leave
80103adf:	c3                   	ret
    panic("userinit: out of memory?");
80103ae0:	83 ec 0c             	sub    $0xc,%esp
80103ae3:	68 cd 84 10 80       	push   $0x801084cd
80103ae8:	e8 93 c8 ff ff       	call   80100380 <panic>
80103aed:	8d 76 00             	lea    0x0(%esi),%esi

80103af0 <growproc>:
{
80103af0:	55                   	push   %ebp
80103af1:	89 e5                	mov    %esp,%ebp
80103af3:	56                   	push   %esi
80103af4:	53                   	push   %ebx
80103af5:	8b 75 08             	mov    0x8(%ebp),%esi
  pushcli();
80103af8:	e8 53 0a 00 00       	call   80104550 <pushcli>
  c = mycpu();
80103afd:	e8 4e fe ff ff       	call   80103950 <mycpu>
  p = c->proc;
80103b02:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103b08:	e8 93 0a 00 00       	call   801045a0 <popcli>
  sz = curproc->sz;
80103b0d:	8b 03                	mov    (%ebx),%eax
  if(n > 0){
80103b0f:	85 f6                	test   %esi,%esi
80103b11:	7f 1d                	jg     80103b30 <growproc+0x40>
  } else if(n < 0){
80103b13:	75 3b                	jne    80103b50 <growproc+0x60>
  switchuvm(curproc);
80103b15:	83 ec 0c             	sub    $0xc,%esp
  curproc->sz = sz;
80103b18:	89 03                	mov    %eax,(%ebx)
  switchuvm(curproc);
80103b1a:	53                   	push   %ebx
80103b1b:	e8 c0 31 00 00       	call   80106ce0 <switchuvm>
  return 0;
80103b20:	83 c4 10             	add    $0x10,%esp
80103b23:	31 c0                	xor    %eax,%eax
}
80103b25:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103b28:	5b                   	pop    %ebx
80103b29:	5e                   	pop    %esi
80103b2a:	5d                   	pop    %ebp
80103b2b:	c3                   	ret
80103b2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
80103b30:	83 ec 04             	sub    $0x4,%esp
80103b33:	01 c6                	add    %eax,%esi
80103b35:	56                   	push   %esi
80103b36:	50                   	push   %eax
80103b37:	ff 73 04             	push   0x4(%ebx)
80103b3a:	e8 01 34 00 00       	call   80106f40 <allocuvm>
80103b3f:	83 c4 10             	add    $0x10,%esp
80103b42:	85 c0                	test   %eax,%eax
80103b44:	75 cf                	jne    80103b15 <growproc+0x25>
      return -1;
80103b46:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103b4b:	eb d8                	jmp    80103b25 <growproc+0x35>
80103b4d:	8d 76 00             	lea    0x0(%esi),%esi
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
80103b50:	83 ec 04             	sub    $0x4,%esp
80103b53:	01 c6                	add    %eax,%esi
80103b55:	56                   	push   %esi
80103b56:	50                   	push   %eax
80103b57:	ff 73 04             	push   0x4(%ebx)
80103b5a:	e8 f1 34 00 00       	call   80107050 <deallocuvm>
80103b5f:	83 c4 10             	add    $0x10,%esp
80103b62:	85 c0                	test   %eax,%eax
80103b64:	75 af                	jne    80103b15 <growproc+0x25>
80103b66:	eb de                	jmp    80103b46 <growproc+0x56>
80103b68:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103b6f:	00 

80103b70 <fork>:
{
80103b70:	55                   	push   %ebp
80103b71:	89 e5                	mov    %esp,%ebp
80103b73:	57                   	push   %edi
80103b74:	56                   	push   %esi
80103b75:	53                   	push   %ebx
80103b76:	83 ec 1c             	sub    $0x1c,%esp
  pushcli();
80103b79:	e8 d2 09 00 00       	call   80104550 <pushcli>
  c = mycpu();
80103b7e:	e8 cd fd ff ff       	call   80103950 <mycpu>
  p = c->proc;
80103b83:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103b89:	e8 12 0a 00 00       	call   801045a0 <popcli>
  if((np = allocproc()) == 0){
80103b8e:	e8 7d fc ff ff       	call   80103810 <allocproc>
80103b93:	85 c0                	test   %eax,%eax
80103b95:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80103b98:	0f 84 67 01 00 00    	je     80103d05 <fork+0x195>
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
80103b9e:	83 ec 08             	sub    $0x8,%esp
80103ba1:	ff 33                	push   (%ebx)
80103ba3:	ff 73 04             	push   0x4(%ebx)
80103ba6:	e8 95 36 00 00       	call   80107240 <copyuvm>
80103bab:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80103bae:	83 c4 10             	add    $0x10,%esp
80103bb1:	89 42 04             	mov    %eax,0x4(%edx)
80103bb4:	85 c0                	test   %eax,%eax
80103bb6:	0f 84 2a 01 00 00    	je     80103ce6 <fork+0x176>
  np->sz = curproc->sz;
80103bbc:	8b 03                	mov    (%ebx),%eax
  *np->tf = *curproc->tf;
80103bbe:	8b 7a 18             	mov    0x18(%edx),%edi
  np->parent = curproc;
80103bc1:	89 5a 14             	mov    %ebx,0x14(%edx)
  *np->tf = *curproc->tf;
80103bc4:	b9 13 00 00 00       	mov    $0x13,%ecx
  np->sz = curproc->sz;
80103bc9:	89 02                	mov    %eax,(%edx)
  *np->tf = *curproc->tf;
80103bcb:	8b 73 18             	mov    0x18(%ebx),%esi
80103bce:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  for(i = 0; i < NOFILE; i++)
80103bd0:	31 f6                	xor    %esi,%esi
  np->tf->eax = 0;
80103bd2:	8b 42 18             	mov    0x18(%edx),%eax
80103bd5:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
  for(i = 0; i < NOFILE; i++)
80103bdc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(curproc->ofile[i])
80103be0:	8b 44 b3 28          	mov    0x28(%ebx,%esi,4),%eax
80103be4:	85 c0                	test   %eax,%eax
80103be6:	74 16                	je     80103bfe <fork+0x8e>
      np->ofile[i] = filedup(curproc->ofile[i]);
80103be8:	83 ec 0c             	sub    $0xc,%esp
80103beb:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80103bee:	50                   	push   %eax
80103bef:	e8 2c d3 ff ff       	call   80100f20 <filedup>
80103bf4:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80103bf7:	83 c4 10             	add    $0x10,%esp
80103bfa:	89 44 b2 28          	mov    %eax,0x28(%edx,%esi,4)
  for(i = 0; i < NOFILE; i++)
80103bfe:	83 c6 01             	add    $0x1,%esi
80103c01:	83 fe 10             	cmp    $0x10,%esi
80103c04:	75 da                	jne    80103be0 <fork+0x70>
  np->cwd = idup(curproc->cwd);
80103c06:	83 ec 0c             	sub    $0xc,%esp
80103c09:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80103c0c:	ff 73 68             	push   0x68(%ebx)
80103c0f:	e8 bc db ff ff       	call   801017d0 <idup>
80103c14:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103c17:	83 c4 0c             	add    $0xc,%esp
  np->cwd = idup(curproc->cwd);
80103c1a:	89 42 68             	mov    %eax,0x68(%edx)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103c1d:	8d 43 6c             	lea    0x6c(%ebx),%eax
80103c20:	6a 10                	push   $0x10
80103c22:	50                   	push   %eax
80103c23:	8d 42 6c             	lea    0x6c(%edx),%eax
80103c26:	50                   	push   %eax
80103c27:	e8 24 0d 00 00       	call   80104950 <safestrcpy>
  pid = np->pid;
80103c2c:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80103c2f:	8b 42 10             	mov    0x10(%edx),%eax
80103c32:	89 45 e0             	mov    %eax,-0x20(%ebp)
  acquire(&ptable.lock);
80103c35:	c7 04 24 80 ad 13 80 	movl   $0x8013ad80,(%esp)
80103c3c:	e8 5f 0a 00 00       	call   801046a0 <acquire>
  if(curproc->pid > 2){
80103c41:	83 c4 10             	add    $0x10,%esp
80103c44:	83 7b 10 02          	cmpl   $0x2,0x10(%ebx)
80103c48:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80103c4b:	7e 70                	jle    80103cbd <fork+0x14d>
  int last_shmid = -2;
80103c4d:	b9 fe ff ff ff       	mov    $0xfffffffe,%ecx
    for (i = 0; i < 4096; i++) {
80103c52:	31 f6                	xor    %esi,%esi
80103c54:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      np->shmsegs[i].isAttached = curproc->shmsegs[i].isAttached;
80103c58:	8b 44 f3 7c          	mov    0x7c(%ebx,%esi,8),%eax
80103c5c:	89 44 f2 7c          	mov    %eax,0x7c(%edx,%esi,8)
      np->shmsegs[i].shmid = curproc->shmsegs[i].shmid;
80103c60:	8b bc f3 80 00 00 00 	mov    0x80(%ebx,%esi,8),%edi
80103c67:	89 bc f2 80 00 00 00 	mov    %edi,0x80(%edx,%esi,8)
      if(temp_shmid == -1 || temp_shmid == last_shmid){
80103c6e:	83 ff ff             	cmp    $0xffffffff,%edi
80103c71:	74 1d                	je     80103c90 <fork+0x120>
80103c73:	39 cf                	cmp    %ecx,%edi
80103c75:	74 19                	je     80103c90 <fork+0x120>
        updateShmSeg(temp_shmid, np->pid, 0);
80103c77:	83 ec 04             	sub    $0x4,%esp
80103c7a:	6a 00                	push   $0x0
80103c7c:	ff 72 10             	push   0x10(%edx)
80103c7f:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80103c82:	57                   	push   %edi
80103c83:	e8 68 38 00 00       	call   801074f0 <updateShmSeg>
        last_shmid = temp_shmid;
80103c88:	8b 55 e4             	mov    -0x1c(%ebp),%edx
        updateShmSeg(temp_shmid, np->pid, 0);
80103c8b:	83 c4 10             	add    $0x10,%esp
        last_shmid = temp_shmid;
80103c8e:	89 f9                	mov    %edi,%ecx
    for (i = 0; i < 4096; i++) {
80103c90:	83 c6 01             	add    $0x1,%esi
80103c93:	81 fe 00 10 00 00    	cmp    $0x1000,%esi
80103c99:	75 bd                	jne    80103c58 <fork+0xe8>
  release(&ptable.lock);
80103c9b:	83 ec 0c             	sub    $0xc,%esp
  np->state = RUNNABLE;
80103c9e:	c7 42 0c 03 00 00 00 	movl   $0x3,0xc(%edx)
  release(&ptable.lock);
80103ca5:	68 80 ad 13 80       	push   $0x8013ad80
80103caa:	e8 91 09 00 00       	call   80104640 <release>
  return pid;
80103caf:	83 c4 10             	add    $0x10,%esp
}
80103cb2:	8b 45 e0             	mov    -0x20(%ebp),%eax
80103cb5:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103cb8:	5b                   	pop    %ebx
80103cb9:	5e                   	pop    %esi
80103cba:	5f                   	pop    %edi
80103cbb:	5d                   	pop    %ebp
80103cbc:	c3                   	ret
80103cbd:	8d 42 7c             	lea    0x7c(%edx),%eax
80103cc0:	8d 8a 7c 80 00 00    	lea    0x807c(%edx),%ecx
80103cc6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103ccd:	00 
80103cce:	66 90                	xchg   %ax,%ax
      np->shmsegs[i].isAttached = 0;
80103cd0:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
    for (i = 0; i < 4096; i++) {
80103cd6:	83 c0 08             	add    $0x8,%eax
      np->shmsegs[i].shmid = -1;
80103cd9:	c7 40 fc ff ff ff ff 	movl   $0xffffffff,-0x4(%eax)
    for (i = 0; i < 4096; i++) {
80103ce0:	39 c8                	cmp    %ecx,%eax
80103ce2:	75 ec                	jne    80103cd0 <fork+0x160>
80103ce4:	eb b5                	jmp    80103c9b <fork+0x12b>
    kfree(np->kstack);
80103ce6:	83 ec 0c             	sub    $0xc,%esp
80103ce9:	ff 72 08             	push   0x8(%edx)
80103cec:	e8 0f e8 ff ff       	call   80102500 <kfree>
    np->kstack = 0;
80103cf1:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    return -1;
80103cf4:	83 c4 10             	add    $0x10,%esp
    np->kstack = 0;
80103cf7:	c7 42 08 00 00 00 00 	movl   $0x0,0x8(%edx)
    np->state = UNUSED;
80103cfe:	c7 42 0c 00 00 00 00 	movl   $0x0,0xc(%edx)
    return -1;
80103d05:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
80103d0c:	eb a4                	jmp    80103cb2 <fork+0x142>
80103d0e:	66 90                	xchg   %ax,%ax

80103d10 <scheduler>:
{
80103d10:	55                   	push   %ebp
80103d11:	89 e5                	mov    %esp,%ebp
80103d13:	57                   	push   %edi
80103d14:	56                   	push   %esi
80103d15:	53                   	push   %ebx
80103d16:	83 ec 0c             	sub    $0xc,%esp
  struct cpu *c = mycpu();
80103d19:	e8 32 fc ff ff       	call   80103950 <mycpu>
  c->proc = 0;
80103d1e:	c7 80 ac 00 00 00 00 	movl   $0x0,0xac(%eax)
80103d25:	00 00 00 
  struct cpu *c = mycpu();
80103d28:	89 c6                	mov    %eax,%esi
  c->proc = 0;
80103d2a:	8d 78 04             	lea    0x4(%eax),%edi
80103d2d:	8d 76 00             	lea    0x0(%esi),%esi
  asm volatile("sti");
80103d30:	fb                   	sti
    acquire(&ptable.lock);
80103d31:	83 ec 0c             	sub    $0xc,%esp
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103d34:	bb b4 ad 13 80       	mov    $0x8013adb4,%ebx
    acquire(&ptable.lock);
80103d39:	68 80 ad 13 80       	push   $0x8013ad80
80103d3e:	e8 5d 09 00 00       	call   801046a0 <acquire>
80103d43:	83 c4 10             	add    $0x10,%esp
80103d46:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103d4d:	00 
80103d4e:	66 90                	xchg   %ax,%ax
      if(p->state != RUNNABLE)
80103d50:	83 7b 0c 03          	cmpl   $0x3,0xc(%ebx)
80103d54:	75 33                	jne    80103d89 <scheduler+0x79>
      switchuvm(p);
80103d56:	83 ec 0c             	sub    $0xc,%esp
      c->proc = p;
80103d59:	89 9e ac 00 00 00    	mov    %ebx,0xac(%esi)
      switchuvm(p);
80103d5f:	53                   	push   %ebx
80103d60:	e8 7b 2f 00 00       	call   80106ce0 <switchuvm>
      swtch(&(c->scheduler), p->context);
80103d65:	58                   	pop    %eax
80103d66:	5a                   	pop    %edx
80103d67:	ff 73 1c             	push   0x1c(%ebx)
80103d6a:	57                   	push   %edi
      p->state = RUNNING;
80103d6b:	c7 43 0c 04 00 00 00 	movl   $0x4,0xc(%ebx)
      swtch(&(c->scheduler), p->context);
80103d72:	e8 34 0c 00 00       	call   801049ab <swtch>
      switchkvm();
80103d77:	e8 54 2f 00 00       	call   80106cd0 <switchkvm>
      c->proc = 0;
80103d7c:	83 c4 10             	add    $0x10,%esp
80103d7f:	c7 86 ac 00 00 00 00 	movl   $0x0,0xac(%esi)
80103d86:	00 00 00 
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103d89:	81 c3 7c 80 00 00    	add    $0x807c,%ebx
80103d8f:	81 fb b4 cc 33 80    	cmp    $0x8033ccb4,%ebx
80103d95:	75 b9                	jne    80103d50 <scheduler+0x40>
    release(&ptable.lock);
80103d97:	83 ec 0c             	sub    $0xc,%esp
80103d9a:	68 80 ad 13 80       	push   $0x8013ad80
80103d9f:	e8 9c 08 00 00       	call   80104640 <release>
    sti();
80103da4:	83 c4 10             	add    $0x10,%esp
80103da7:	eb 87                	jmp    80103d30 <scheduler+0x20>
80103da9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103db0 <sched>:
{
80103db0:	55                   	push   %ebp
80103db1:	89 e5                	mov    %esp,%ebp
80103db3:	56                   	push   %esi
80103db4:	53                   	push   %ebx
  pushcli();
80103db5:	e8 96 07 00 00       	call   80104550 <pushcli>
  c = mycpu();
80103dba:	e8 91 fb ff ff       	call   80103950 <mycpu>
  p = c->proc;
80103dbf:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103dc5:	e8 d6 07 00 00       	call   801045a0 <popcli>
  if(!holding(&ptable.lock))
80103dca:	83 ec 0c             	sub    $0xc,%esp
80103dcd:	68 80 ad 13 80       	push   $0x8013ad80
80103dd2:	e8 29 08 00 00       	call   80104600 <holding>
80103dd7:	83 c4 10             	add    $0x10,%esp
80103dda:	85 c0                	test   %eax,%eax
80103ddc:	74 4f                	je     80103e2d <sched+0x7d>
  if(mycpu()->ncli != 1)
80103dde:	e8 6d fb ff ff       	call   80103950 <mycpu>
80103de3:	83 b8 a4 00 00 00 01 	cmpl   $0x1,0xa4(%eax)
80103dea:	75 68                	jne    80103e54 <sched+0xa4>
  if(p->state == RUNNING)
80103dec:	83 7b 0c 04          	cmpl   $0x4,0xc(%ebx)
80103df0:	74 55                	je     80103e47 <sched+0x97>
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103df2:	9c                   	pushf
80103df3:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80103df4:	f6 c4 02             	test   $0x2,%ah
80103df7:	75 41                	jne    80103e3a <sched+0x8a>
  intena = mycpu()->intena;
80103df9:	e8 52 fb ff ff       	call   80103950 <mycpu>
  swtch(&p->context, mycpu()->scheduler);
80103dfe:	83 c3 1c             	add    $0x1c,%ebx
  intena = mycpu()->intena;
80103e01:	8b b0 a8 00 00 00    	mov    0xa8(%eax),%esi
  swtch(&p->context, mycpu()->scheduler);
80103e07:	e8 44 fb ff ff       	call   80103950 <mycpu>
80103e0c:	83 ec 08             	sub    $0x8,%esp
80103e0f:	ff 70 04             	push   0x4(%eax)
80103e12:	53                   	push   %ebx
80103e13:	e8 93 0b 00 00       	call   801049ab <swtch>
  mycpu()->intena = intena;
80103e18:	e8 33 fb ff ff       	call   80103950 <mycpu>
}
80103e1d:	83 c4 10             	add    $0x10,%esp
  mycpu()->intena = intena;
80103e20:	89 b0 a8 00 00 00    	mov    %esi,0xa8(%eax)
}
80103e26:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103e29:	5b                   	pop    %ebx
80103e2a:	5e                   	pop    %esi
80103e2b:	5d                   	pop    %ebp
80103e2c:	c3                   	ret
    panic("sched ptable.lock");
80103e2d:	83 ec 0c             	sub    $0xc,%esp
80103e30:	68 f1 84 10 80       	push   $0x801084f1
80103e35:	e8 46 c5 ff ff       	call   80100380 <panic>
    panic("sched interruptible");
80103e3a:	83 ec 0c             	sub    $0xc,%esp
80103e3d:	68 1d 85 10 80       	push   $0x8010851d
80103e42:	e8 39 c5 ff ff       	call   80100380 <panic>
    panic("sched running");
80103e47:	83 ec 0c             	sub    $0xc,%esp
80103e4a:	68 0f 85 10 80       	push   $0x8010850f
80103e4f:	e8 2c c5 ff ff       	call   80100380 <panic>
    panic("sched locks");
80103e54:	83 ec 0c             	sub    $0xc,%esp
80103e57:	68 03 85 10 80       	push   $0x80108503
80103e5c:	e8 1f c5 ff ff       	call   80100380 <panic>
80103e61:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103e68:	00 
80103e69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103e70 <exit>:
{
80103e70:	55                   	push   %ebp
80103e71:	89 e5                	mov    %esp,%ebp
80103e73:	57                   	push   %edi
80103e74:	56                   	push   %esi
80103e75:	53                   	push   %ebx
80103e76:	83 ec 0c             	sub    $0xc,%esp
  struct proc *curproc = myproc();
80103e79:	e8 52 fb ff ff       	call   801039d0 <myproc>
  if(curproc == initproc)
80103e7e:	39 05 b4 cc 33 80    	cmp    %eax,0x8033ccb4
80103e84:	0f 84 07 01 00 00    	je     80103f91 <exit+0x121>
80103e8a:	89 c3                	mov    %eax,%ebx
80103e8c:	8d 70 28             	lea    0x28(%eax),%esi
80103e8f:	8d 78 68             	lea    0x68(%eax),%edi
80103e92:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(curproc->ofile[fd]){
80103e98:	8b 06                	mov    (%esi),%eax
80103e9a:	85 c0                	test   %eax,%eax
80103e9c:	74 12                	je     80103eb0 <exit+0x40>
      fileclose(curproc->ofile[fd]);
80103e9e:	83 ec 0c             	sub    $0xc,%esp
80103ea1:	50                   	push   %eax
80103ea2:	e8 c9 d0 ff ff       	call   80100f70 <fileclose>
      curproc->ofile[fd] = 0;
80103ea7:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
80103ead:	83 c4 10             	add    $0x10,%esp
  for(fd = 0; fd < NOFILE; fd++){
80103eb0:	83 c6 04             	add    $0x4,%esi
80103eb3:	39 f7                	cmp    %esi,%edi
80103eb5:	75 e1                	jne    80103e98 <exit+0x28>
  begin_op();
80103eb7:	e8 e4 ee ff ff       	call   80102da0 <begin_op>
  iput(curproc->cwd);
80103ebc:	83 ec 0c             	sub    $0xc,%esp
80103ebf:	ff 73 68             	push   0x68(%ebx)
80103ec2:	e8 69 da ff ff       	call   80101930 <iput>
  end_op();
80103ec7:	e8 44 ef ff ff       	call   80102e10 <end_op>
  curproc->cwd = 0;
80103ecc:	c7 43 68 00 00 00 00 	movl   $0x0,0x68(%ebx)
  acquire(&ptable.lock);
80103ed3:	c7 04 24 80 ad 13 80 	movl   $0x8013ad80,(%esp)
80103eda:	e8 c1 07 00 00       	call   801046a0 <acquire>
  wakeup1(curproc->parent);
80103edf:	8b 53 14             	mov    0x14(%ebx),%edx
80103ee2:	83 c4 10             	add    $0x10,%esp
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103ee5:	b8 b4 ad 13 80       	mov    $0x8013adb4,%eax
80103eea:	eb 10                	jmp    80103efc <exit+0x8c>
80103eec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103ef0:	05 7c 80 00 00       	add    $0x807c,%eax
80103ef5:	3d b4 cc 33 80       	cmp    $0x8033ccb4,%eax
80103efa:	74 1e                	je     80103f1a <exit+0xaa>
    if(p->state == SLEEPING && p->chan == chan)
80103efc:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80103f00:	75 ee                	jne    80103ef0 <exit+0x80>
80103f02:	3b 50 20             	cmp    0x20(%eax),%edx
80103f05:	75 e9                	jne    80103ef0 <exit+0x80>
      p->state = RUNNABLE;
80103f07:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103f0e:	05 7c 80 00 00       	add    $0x807c,%eax
80103f13:	3d b4 cc 33 80       	cmp    $0x8033ccb4,%eax
80103f18:	75 e2                	jne    80103efc <exit+0x8c>
      p->parent = initproc;
80103f1a:	8b 0d b4 cc 33 80    	mov    0x8033ccb4,%ecx
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103f20:	ba b4 ad 13 80       	mov    $0x8013adb4,%edx
80103f25:	eb 17                	jmp    80103f3e <exit+0xce>
80103f27:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103f2e:	00 
80103f2f:	90                   	nop
80103f30:	81 c2 7c 80 00 00    	add    $0x807c,%edx
80103f36:	81 fa b4 cc 33 80    	cmp    $0x8033ccb4,%edx
80103f3c:	74 3a                	je     80103f78 <exit+0x108>
    if(p->parent == curproc){
80103f3e:	39 5a 14             	cmp    %ebx,0x14(%edx)
80103f41:	75 ed                	jne    80103f30 <exit+0xc0>
      if(p->state == ZOMBIE)
80103f43:	83 7a 0c 05          	cmpl   $0x5,0xc(%edx)
      p->parent = initproc;
80103f47:	89 4a 14             	mov    %ecx,0x14(%edx)
      if(p->state == ZOMBIE)
80103f4a:	75 e4                	jne    80103f30 <exit+0xc0>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103f4c:	b8 b4 ad 13 80       	mov    $0x8013adb4,%eax
80103f51:	eb 11                	jmp    80103f64 <exit+0xf4>
80103f53:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80103f58:	05 7c 80 00 00       	add    $0x807c,%eax
80103f5d:	3d b4 cc 33 80       	cmp    $0x8033ccb4,%eax
80103f62:	74 cc                	je     80103f30 <exit+0xc0>
    if(p->state == SLEEPING && p->chan == chan)
80103f64:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80103f68:	75 ee                	jne    80103f58 <exit+0xe8>
80103f6a:	3b 48 20             	cmp    0x20(%eax),%ecx
80103f6d:	75 e9                	jne    80103f58 <exit+0xe8>
      p->state = RUNNABLE;
80103f6f:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
80103f76:	eb e0                	jmp    80103f58 <exit+0xe8>
  curproc->state = ZOMBIE;
80103f78:	c7 43 0c 05 00 00 00 	movl   $0x5,0xc(%ebx)
  sched();
80103f7f:	e8 2c fe ff ff       	call   80103db0 <sched>
  panic("zombie exit");
80103f84:	83 ec 0c             	sub    $0xc,%esp
80103f87:	68 3e 85 10 80       	push   $0x8010853e
80103f8c:	e8 ef c3 ff ff       	call   80100380 <panic>
    panic("init exiting");
80103f91:	83 ec 0c             	sub    $0xc,%esp
80103f94:	68 31 85 10 80       	push   $0x80108531
80103f99:	e8 e2 c3 ff ff       	call   80100380 <panic>
80103f9e:	66 90                	xchg   %ax,%ax

80103fa0 <wait>:
{
80103fa0:	55                   	push   %ebp
80103fa1:	89 e5                	mov    %esp,%ebp
80103fa3:	56                   	push   %esi
80103fa4:	53                   	push   %ebx
  pushcli();
80103fa5:	e8 a6 05 00 00       	call   80104550 <pushcli>
  c = mycpu();
80103faa:	e8 a1 f9 ff ff       	call   80103950 <mycpu>
  p = c->proc;
80103faf:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80103fb5:	e8 e6 05 00 00       	call   801045a0 <popcli>
  acquire(&ptable.lock);
80103fba:	83 ec 0c             	sub    $0xc,%esp
80103fbd:	68 80 ad 13 80       	push   $0x8013ad80
80103fc2:	e8 d9 06 00 00       	call   801046a0 <acquire>
80103fc7:	83 c4 10             	add    $0x10,%esp
    havekids = 0;
80103fca:	31 c0                	xor    %eax,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103fcc:	bb b4 ad 13 80       	mov    $0x8013adb4,%ebx
80103fd1:	eb 13                	jmp    80103fe6 <wait+0x46>
80103fd3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80103fd8:	81 c3 7c 80 00 00    	add    $0x807c,%ebx
80103fde:	81 fb b4 cc 33 80    	cmp    $0x8033ccb4,%ebx
80103fe4:	74 1e                	je     80104004 <wait+0x64>
      if(p->parent != curproc)
80103fe6:	39 73 14             	cmp    %esi,0x14(%ebx)
80103fe9:	75 ed                	jne    80103fd8 <wait+0x38>
      if(p->state == ZOMBIE){
80103feb:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
80103fef:	74 5f                	je     80104050 <wait+0xb0>
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103ff1:	81 c3 7c 80 00 00    	add    $0x807c,%ebx
      havekids = 1;
80103ff7:	b8 01 00 00 00       	mov    $0x1,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103ffc:	81 fb b4 cc 33 80    	cmp    $0x8033ccb4,%ebx
80104002:	75 e2                	jne    80103fe6 <wait+0x46>
    if(!havekids || curproc->killed){
80104004:	85 c0                	test   %eax,%eax
80104006:	0f 84 9a 00 00 00    	je     801040a6 <wait+0x106>
8010400c:	8b 46 24             	mov    0x24(%esi),%eax
8010400f:	85 c0                	test   %eax,%eax
80104011:	0f 85 8f 00 00 00    	jne    801040a6 <wait+0x106>
  pushcli();
80104017:	e8 34 05 00 00       	call   80104550 <pushcli>
  c = mycpu();
8010401c:	e8 2f f9 ff ff       	call   80103950 <mycpu>
  p = c->proc;
80104021:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104027:	e8 74 05 00 00       	call   801045a0 <popcli>
  if(p == 0)
8010402c:	85 db                	test   %ebx,%ebx
8010402e:	0f 84 89 00 00 00    	je     801040bd <wait+0x11d>
  p->chan = chan;
80104034:	89 73 20             	mov    %esi,0x20(%ebx)
  p->state = SLEEPING;
80104037:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
8010403e:	e8 6d fd ff ff       	call   80103db0 <sched>
  p->chan = 0;
80104043:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
}
8010404a:	e9 7b ff ff ff       	jmp    80103fca <wait+0x2a>
8010404f:	90                   	nop
        kfree(p->kstack);
80104050:	83 ec 0c             	sub    $0xc,%esp
        pid = p->pid;
80104053:	8b 73 10             	mov    0x10(%ebx),%esi
        kfree(p->kstack);
80104056:	ff 73 08             	push   0x8(%ebx)
80104059:	e8 a2 e4 ff ff       	call   80102500 <kfree>
        p->kstack = 0;
8010405e:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
        freevm(p->pgdir);
80104065:	5a                   	pop    %edx
80104066:	ff 73 04             	push   0x4(%ebx)
80104069:	e8 12 30 00 00       	call   80107080 <freevm>
        p->pid = 0;
8010406e:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
        p->parent = 0;
80104075:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
        p->name[0] = 0;
8010407c:	c6 43 6c 00          	movb   $0x0,0x6c(%ebx)
        p->killed = 0;
80104080:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
        p->state = UNUSED;
80104087:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
        release(&ptable.lock);
8010408e:	c7 04 24 80 ad 13 80 	movl   $0x8013ad80,(%esp)
80104095:	e8 a6 05 00 00       	call   80104640 <release>
        return pid;
8010409a:	83 c4 10             	add    $0x10,%esp
}
8010409d:	8d 65 f8             	lea    -0x8(%ebp),%esp
801040a0:	89 f0                	mov    %esi,%eax
801040a2:	5b                   	pop    %ebx
801040a3:	5e                   	pop    %esi
801040a4:	5d                   	pop    %ebp
801040a5:	c3                   	ret
      release(&ptable.lock);
801040a6:	83 ec 0c             	sub    $0xc,%esp
      return -1;
801040a9:	be ff ff ff ff       	mov    $0xffffffff,%esi
      release(&ptable.lock);
801040ae:	68 80 ad 13 80       	push   $0x8013ad80
801040b3:	e8 88 05 00 00       	call   80104640 <release>
      return -1;
801040b8:	83 c4 10             	add    $0x10,%esp
801040bb:	eb e0                	jmp    8010409d <wait+0xfd>
    panic("sleep");
801040bd:	83 ec 0c             	sub    $0xc,%esp
801040c0:	68 4a 85 10 80       	push   $0x8010854a
801040c5:	e8 b6 c2 ff ff       	call   80100380 <panic>
801040ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801040d0 <yield>:
{
801040d0:	55                   	push   %ebp
801040d1:	89 e5                	mov    %esp,%ebp
801040d3:	53                   	push   %ebx
801040d4:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);  //DOC: yieldlock
801040d7:	68 80 ad 13 80       	push   $0x8013ad80
801040dc:	e8 bf 05 00 00       	call   801046a0 <acquire>
  pushcli();
801040e1:	e8 6a 04 00 00       	call   80104550 <pushcli>
  c = mycpu();
801040e6:	e8 65 f8 ff ff       	call   80103950 <mycpu>
  p = c->proc;
801040eb:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801040f1:	e8 aa 04 00 00       	call   801045a0 <popcli>
  myproc()->state = RUNNABLE;
801040f6:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  sched();
801040fd:	e8 ae fc ff ff       	call   80103db0 <sched>
  release(&ptable.lock);
80104102:	c7 04 24 80 ad 13 80 	movl   $0x8013ad80,(%esp)
80104109:	e8 32 05 00 00       	call   80104640 <release>
}
8010410e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104111:	83 c4 10             	add    $0x10,%esp
80104114:	c9                   	leave
80104115:	c3                   	ret
80104116:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010411d:	00 
8010411e:	66 90                	xchg   %ax,%ax

80104120 <sleep>:
{
80104120:	55                   	push   %ebp
80104121:	89 e5                	mov    %esp,%ebp
80104123:	57                   	push   %edi
80104124:	56                   	push   %esi
80104125:	53                   	push   %ebx
80104126:	83 ec 0c             	sub    $0xc,%esp
80104129:	8b 7d 08             	mov    0x8(%ebp),%edi
8010412c:	8b 75 0c             	mov    0xc(%ebp),%esi
  pushcli();
8010412f:	e8 1c 04 00 00       	call   80104550 <pushcli>
  c = mycpu();
80104134:	e8 17 f8 ff ff       	call   80103950 <mycpu>
  p = c->proc;
80104139:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
8010413f:	e8 5c 04 00 00       	call   801045a0 <popcli>
  if(p == 0)
80104144:	85 db                	test   %ebx,%ebx
80104146:	0f 84 87 00 00 00    	je     801041d3 <sleep+0xb3>
  if(lk == 0)
8010414c:	85 f6                	test   %esi,%esi
8010414e:	74 76                	je     801041c6 <sleep+0xa6>
  if(lk != &ptable.lock){  //DOC: sleeplock0
80104150:	81 fe 80 ad 13 80    	cmp    $0x8013ad80,%esi
80104156:	74 50                	je     801041a8 <sleep+0x88>
    acquire(&ptable.lock);  //DOC: sleeplock1
80104158:	83 ec 0c             	sub    $0xc,%esp
8010415b:	68 80 ad 13 80       	push   $0x8013ad80
80104160:	e8 3b 05 00 00       	call   801046a0 <acquire>
    release(lk);
80104165:	89 34 24             	mov    %esi,(%esp)
80104168:	e8 d3 04 00 00       	call   80104640 <release>
  p->chan = chan;
8010416d:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
80104170:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
80104177:	e8 34 fc ff ff       	call   80103db0 <sched>
  p->chan = 0;
8010417c:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
    release(&ptable.lock);
80104183:	c7 04 24 80 ad 13 80 	movl   $0x8013ad80,(%esp)
8010418a:	e8 b1 04 00 00       	call   80104640 <release>
    acquire(lk);
8010418f:	83 c4 10             	add    $0x10,%esp
80104192:	89 75 08             	mov    %esi,0x8(%ebp)
}
80104195:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104198:	5b                   	pop    %ebx
80104199:	5e                   	pop    %esi
8010419a:	5f                   	pop    %edi
8010419b:	5d                   	pop    %ebp
    acquire(lk);
8010419c:	e9 ff 04 00 00       	jmp    801046a0 <acquire>
801041a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  p->chan = chan;
801041a8:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
801041ab:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
801041b2:	e8 f9 fb ff ff       	call   80103db0 <sched>
  p->chan = 0;
801041b7:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
}
801041be:	8d 65 f4             	lea    -0xc(%ebp),%esp
801041c1:	5b                   	pop    %ebx
801041c2:	5e                   	pop    %esi
801041c3:	5f                   	pop    %edi
801041c4:	5d                   	pop    %ebp
801041c5:	c3                   	ret
    panic("sleep without lk");
801041c6:	83 ec 0c             	sub    $0xc,%esp
801041c9:	68 50 85 10 80       	push   $0x80108550
801041ce:	e8 ad c1 ff ff       	call   80100380 <panic>
    panic("sleep");
801041d3:	83 ec 0c             	sub    $0xc,%esp
801041d6:	68 4a 85 10 80       	push   $0x8010854a
801041db:	e8 a0 c1 ff ff       	call   80100380 <panic>

801041e0 <wakeup>:
}

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
801041e0:	55                   	push   %ebp
801041e1:	89 e5                	mov    %esp,%ebp
801041e3:	53                   	push   %ebx
801041e4:	83 ec 10             	sub    $0x10,%esp
801041e7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock);
801041ea:	68 80 ad 13 80       	push   $0x8013ad80
801041ef:	e8 ac 04 00 00       	call   801046a0 <acquire>
801041f4:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801041f7:	b8 b4 ad 13 80       	mov    $0x8013adb4,%eax
801041fc:	eb 0e                	jmp    8010420c <wakeup+0x2c>
801041fe:	66 90                	xchg   %ax,%ax
80104200:	05 7c 80 00 00       	add    $0x807c,%eax
80104205:	3d b4 cc 33 80       	cmp    $0x8033ccb4,%eax
8010420a:	74 1e                	je     8010422a <wakeup+0x4a>
    if(p->state == SLEEPING && p->chan == chan)
8010420c:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80104210:	75 ee                	jne    80104200 <wakeup+0x20>
80104212:	3b 58 20             	cmp    0x20(%eax),%ebx
80104215:	75 e9                	jne    80104200 <wakeup+0x20>
      p->state = RUNNABLE;
80104217:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010421e:	05 7c 80 00 00       	add    $0x807c,%eax
80104223:	3d b4 cc 33 80       	cmp    $0x8033ccb4,%eax
80104228:	75 e2                	jne    8010420c <wakeup+0x2c>
  wakeup1(chan);
  release(&ptable.lock);
8010422a:	c7 45 08 80 ad 13 80 	movl   $0x8013ad80,0x8(%ebp)
}
80104231:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104234:	c9                   	leave
  release(&ptable.lock);
80104235:	e9 06 04 00 00       	jmp    80104640 <release>
8010423a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104240 <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
80104240:	55                   	push   %ebp
80104241:	89 e5                	mov    %esp,%ebp
80104243:	53                   	push   %ebx
80104244:	83 ec 10             	sub    $0x10,%esp
80104247:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *p;

  acquire(&ptable.lock);
8010424a:	68 80 ad 13 80       	push   $0x8013ad80
8010424f:	e8 4c 04 00 00       	call   801046a0 <acquire>
80104254:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104257:	b8 b4 ad 13 80       	mov    $0x8013adb4,%eax
8010425c:	eb 0e                	jmp    8010426c <kill+0x2c>
8010425e:	66 90                	xchg   %ax,%ax
80104260:	05 7c 80 00 00       	add    $0x807c,%eax
80104265:	3d b4 cc 33 80       	cmp    $0x8033ccb4,%eax
8010426a:	74 34                	je     801042a0 <kill+0x60>
    if(p->pid == pid){
8010426c:	39 58 10             	cmp    %ebx,0x10(%eax)
8010426f:	75 ef                	jne    80104260 <kill+0x20>
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
80104271:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
      p->killed = 1;
80104275:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
      if(p->state == SLEEPING)
8010427c:	75 07                	jne    80104285 <kill+0x45>
        p->state = RUNNABLE;
8010427e:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
      release(&ptable.lock);
80104285:	83 ec 0c             	sub    $0xc,%esp
80104288:	68 80 ad 13 80       	push   $0x8013ad80
8010428d:	e8 ae 03 00 00       	call   80104640 <release>
      return 0;
    }
  }
  release(&ptable.lock);
  return -1;
}
80104292:	8b 5d fc             	mov    -0x4(%ebp),%ebx
      return 0;
80104295:	83 c4 10             	add    $0x10,%esp
80104298:	31 c0                	xor    %eax,%eax
}
8010429a:	c9                   	leave
8010429b:	c3                   	ret
8010429c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  release(&ptable.lock);
801042a0:	83 ec 0c             	sub    $0xc,%esp
801042a3:	68 80 ad 13 80       	push   $0x8013ad80
801042a8:	e8 93 03 00 00       	call   80104640 <release>
}
801042ad:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  return -1;
801042b0:	83 c4 10             	add    $0x10,%esp
801042b3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801042b8:	c9                   	leave
801042b9:	c3                   	ret
801042ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801042c0 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
801042c0:	55                   	push   %ebp
801042c1:	89 e5                	mov    %esp,%ebp
801042c3:	57                   	push   %edi
801042c4:	56                   	push   %esi
801042c5:	8d 75 e8             	lea    -0x18(%ebp),%esi
801042c8:	53                   	push   %ebx
801042c9:	bb 20 ae 13 80       	mov    $0x8013ae20,%ebx
801042ce:	83 ec 3c             	sub    $0x3c,%esp
801042d1:	eb 27                	jmp    801042fa <procdump+0x3a>
801042d3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
801042d8:	83 ec 0c             	sub    $0xc,%esp
801042db:	68 5f 88 10 80       	push   $0x8010885f
801042e0:	e8 cb c3 ff ff       	call   801006b0 <cprintf>
801042e5:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801042e8:	81 c3 7c 80 00 00    	add    $0x807c,%ebx
801042ee:	81 fb 20 cd 33 80    	cmp    $0x8033cd20,%ebx
801042f4:	0f 84 7e 00 00 00    	je     80104378 <procdump+0xb8>
    if(p->state == UNUSED)
801042fa:	8b 43 a0             	mov    -0x60(%ebx),%eax
801042fd:	85 c0                	test   %eax,%eax
801042ff:	74 e7                	je     801042e8 <procdump+0x28>
      state = "???";
80104301:	ba 61 85 10 80       	mov    $0x80108561,%edx
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
80104306:	83 f8 05             	cmp    $0x5,%eax
80104309:	77 11                	ja     8010431c <procdump+0x5c>
8010430b:	8b 14 85 c0 8c 10 80 	mov    -0x7fef7340(,%eax,4),%edx
      state = "???";
80104312:	b8 61 85 10 80       	mov    $0x80108561,%eax
80104317:	85 d2                	test   %edx,%edx
80104319:	0f 44 d0             	cmove  %eax,%edx
    cprintf("%d %s %s", p->pid, state, p->name);
8010431c:	53                   	push   %ebx
8010431d:	52                   	push   %edx
8010431e:	ff 73 a4             	push   -0x5c(%ebx)
80104321:	68 65 85 10 80       	push   $0x80108565
80104326:	e8 85 c3 ff ff       	call   801006b0 <cprintf>
    if(p->state == SLEEPING){
8010432b:	83 c4 10             	add    $0x10,%esp
8010432e:	83 7b a0 02          	cmpl   $0x2,-0x60(%ebx)
80104332:	75 a4                	jne    801042d8 <procdump+0x18>
      getcallerpcs((uint*)p->context->ebp+2, pc);
80104334:	83 ec 08             	sub    $0x8,%esp
80104337:	8d 45 c0             	lea    -0x40(%ebp),%eax
8010433a:	8d 7d c0             	lea    -0x40(%ebp),%edi
8010433d:	50                   	push   %eax
8010433e:	8b 43 b0             	mov    -0x50(%ebx),%eax
80104341:	8b 40 0c             	mov    0xc(%eax),%eax
80104344:	83 c0 08             	add    $0x8,%eax
80104347:	50                   	push   %eax
80104348:	e8 83 01 00 00       	call   801044d0 <getcallerpcs>
      for(i=0; i<10 && pc[i] != 0; i++)
8010434d:	83 c4 10             	add    $0x10,%esp
80104350:	8b 17                	mov    (%edi),%edx
80104352:	85 d2                	test   %edx,%edx
80104354:	74 82                	je     801042d8 <procdump+0x18>
        cprintf(" %p", pc[i]);
80104356:	83 ec 08             	sub    $0x8,%esp
      for(i=0; i<10 && pc[i] != 0; i++)
80104359:	83 c7 04             	add    $0x4,%edi
        cprintf(" %p", pc[i]);
8010435c:	52                   	push   %edx
8010435d:	68 a1 82 10 80       	push   $0x801082a1
80104362:	e8 49 c3 ff ff       	call   801006b0 <cprintf>
      for(i=0; i<10 && pc[i] != 0; i++)
80104367:	83 c4 10             	add    $0x10,%esp
8010436a:	39 f7                	cmp    %esi,%edi
8010436c:	75 e2                	jne    80104350 <procdump+0x90>
8010436e:	e9 65 ff ff ff       	jmp    801042d8 <procdump+0x18>
80104373:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  }
}
80104378:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010437b:	5b                   	pop    %ebx
8010437c:	5e                   	pop    %esi
8010437d:	5f                   	pop    %edi
8010437e:	5d                   	pop    %ebp
8010437f:	c3                   	ret

80104380 <initsleeplock>:
#include "spinlock.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
80104380:	55                   	push   %ebp
80104381:	89 e5                	mov    %esp,%ebp
80104383:	53                   	push   %ebx
80104384:	83 ec 0c             	sub    $0xc,%esp
80104387:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&lk->lk, "sleep lock");
8010438a:	68 98 85 10 80       	push   $0x80108598
8010438f:	8d 43 04             	lea    0x4(%ebx),%eax
80104392:	50                   	push   %eax
80104393:	e8 18 01 00 00       	call   801044b0 <initlock>
  lk->name = name;
80104398:	8b 45 0c             	mov    0xc(%ebp),%eax
  lk->locked = 0;
8010439b:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
}
801043a1:	83 c4 10             	add    $0x10,%esp
  lk->pid = 0;
801043a4:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  lk->name = name;
801043ab:	89 43 38             	mov    %eax,0x38(%ebx)
}
801043ae:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801043b1:	c9                   	leave
801043b2:	c3                   	ret
801043b3:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801043ba:	00 
801043bb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

801043c0 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
801043c0:	55                   	push   %ebp
801043c1:	89 e5                	mov    %esp,%ebp
801043c3:	56                   	push   %esi
801043c4:	53                   	push   %ebx
801043c5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
801043c8:	8d 73 04             	lea    0x4(%ebx),%esi
801043cb:	83 ec 0c             	sub    $0xc,%esp
801043ce:	56                   	push   %esi
801043cf:	e8 cc 02 00 00       	call   801046a0 <acquire>
  while (lk->locked) {
801043d4:	8b 13                	mov    (%ebx),%edx
801043d6:	83 c4 10             	add    $0x10,%esp
801043d9:	85 d2                	test   %edx,%edx
801043db:	74 16                	je     801043f3 <acquiresleep+0x33>
801043dd:	8d 76 00             	lea    0x0(%esi),%esi
    sleep(lk, &lk->lk);
801043e0:	83 ec 08             	sub    $0x8,%esp
801043e3:	56                   	push   %esi
801043e4:	53                   	push   %ebx
801043e5:	e8 36 fd ff ff       	call   80104120 <sleep>
  while (lk->locked) {
801043ea:	8b 03                	mov    (%ebx),%eax
801043ec:	83 c4 10             	add    $0x10,%esp
801043ef:	85 c0                	test   %eax,%eax
801043f1:	75 ed                	jne    801043e0 <acquiresleep+0x20>
  }
  lk->locked = 1;
801043f3:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  lk->pid = myproc()->pid;
801043f9:	e8 d2 f5 ff ff       	call   801039d0 <myproc>
801043fe:	8b 40 10             	mov    0x10(%eax),%eax
80104401:	89 43 3c             	mov    %eax,0x3c(%ebx)
  release(&lk->lk);
80104404:	89 75 08             	mov    %esi,0x8(%ebp)
}
80104407:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010440a:	5b                   	pop    %ebx
8010440b:	5e                   	pop    %esi
8010440c:	5d                   	pop    %ebp
  release(&lk->lk);
8010440d:	e9 2e 02 00 00       	jmp    80104640 <release>
80104412:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104419:	00 
8010441a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104420 <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
80104420:	55                   	push   %ebp
80104421:	89 e5                	mov    %esp,%ebp
80104423:	56                   	push   %esi
80104424:	53                   	push   %ebx
80104425:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80104428:	8d 73 04             	lea    0x4(%ebx),%esi
8010442b:	83 ec 0c             	sub    $0xc,%esp
8010442e:	56                   	push   %esi
8010442f:	e8 6c 02 00 00       	call   801046a0 <acquire>
  lk->locked = 0;
80104434:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
8010443a:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  wakeup(lk);
80104441:	89 1c 24             	mov    %ebx,(%esp)
80104444:	e8 97 fd ff ff       	call   801041e0 <wakeup>
  release(&lk->lk);
80104449:	83 c4 10             	add    $0x10,%esp
8010444c:	89 75 08             	mov    %esi,0x8(%ebp)
}
8010444f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104452:	5b                   	pop    %ebx
80104453:	5e                   	pop    %esi
80104454:	5d                   	pop    %ebp
  release(&lk->lk);
80104455:	e9 e6 01 00 00       	jmp    80104640 <release>
8010445a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104460 <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
80104460:	55                   	push   %ebp
80104461:	89 e5                	mov    %esp,%ebp
80104463:	57                   	push   %edi
80104464:	31 ff                	xor    %edi,%edi
80104466:	56                   	push   %esi
80104467:	53                   	push   %ebx
80104468:	83 ec 18             	sub    $0x18,%esp
8010446b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int r;
  
  acquire(&lk->lk);
8010446e:	8d 73 04             	lea    0x4(%ebx),%esi
80104471:	56                   	push   %esi
80104472:	e8 29 02 00 00       	call   801046a0 <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
80104477:	8b 03                	mov    (%ebx),%eax
80104479:	83 c4 10             	add    $0x10,%esp
8010447c:	85 c0                	test   %eax,%eax
8010447e:	75 18                	jne    80104498 <holdingsleep+0x38>
  release(&lk->lk);
80104480:	83 ec 0c             	sub    $0xc,%esp
80104483:	56                   	push   %esi
80104484:	e8 b7 01 00 00       	call   80104640 <release>
  return r;
}
80104489:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010448c:	89 f8                	mov    %edi,%eax
8010448e:	5b                   	pop    %ebx
8010448f:	5e                   	pop    %esi
80104490:	5f                   	pop    %edi
80104491:	5d                   	pop    %ebp
80104492:	c3                   	ret
80104493:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  r = lk->locked && (lk->pid == myproc()->pid);
80104498:	8b 5b 3c             	mov    0x3c(%ebx),%ebx
8010449b:	e8 30 f5 ff ff       	call   801039d0 <myproc>
801044a0:	39 58 10             	cmp    %ebx,0x10(%eax)
801044a3:	0f 94 c0             	sete   %al
801044a6:	0f b6 c0             	movzbl %al,%eax
801044a9:	89 c7                	mov    %eax,%edi
801044ab:	eb d3                	jmp    80104480 <holdingsleep+0x20>
801044ad:	66 90                	xchg   %ax,%ax
801044af:	90                   	nop

801044b0 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
801044b0:	55                   	push   %ebp
801044b1:	89 e5                	mov    %esp,%ebp
801044b3:	8b 45 08             	mov    0x8(%ebp),%eax
  lk->name = name;
801044b6:	8b 55 0c             	mov    0xc(%ebp),%edx
  lk->locked = 0;
801044b9:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->name = name;
801044bf:	89 50 04             	mov    %edx,0x4(%eax)
  lk->cpu = 0;
801044c2:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
801044c9:	5d                   	pop    %ebp
801044ca:	c3                   	ret
801044cb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

801044d0 <getcallerpcs>:
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
801044d0:	55                   	push   %ebp
801044d1:	89 e5                	mov    %esp,%ebp
801044d3:	53                   	push   %ebx
801044d4:	8b 45 08             	mov    0x8(%ebp),%eax
801044d7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
801044da:	8d 50 f8             	lea    -0x8(%eax),%edx
  for(i = 0; i < 10; i++){
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
801044dd:	05 f8 ff ff 7f       	add    $0x7ffffff8,%eax
801044e2:	3d fe ff ff 7f       	cmp    $0x7ffffffe,%eax
  for(i = 0; i < 10; i++){
801044e7:	b8 00 00 00 00       	mov    $0x0,%eax
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
801044ec:	76 10                	jbe    801044fe <getcallerpcs+0x2e>
801044ee:	eb 28                	jmp    80104518 <getcallerpcs+0x48>
801044f0:	8d 9a 00 00 00 80    	lea    -0x80000000(%edx),%ebx
801044f6:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
801044fc:	77 1a                	ja     80104518 <getcallerpcs+0x48>
      break;
    pcs[i] = ebp[1];     // saved %eip
801044fe:	8b 5a 04             	mov    0x4(%edx),%ebx
80104501:	89 1c 81             	mov    %ebx,(%ecx,%eax,4)
  for(i = 0; i < 10; i++){
80104504:	83 c0 01             	add    $0x1,%eax
    ebp = (uint*)ebp[0]; // saved %ebp
80104507:	8b 12                	mov    (%edx),%edx
  for(i = 0; i < 10; i++){
80104509:	83 f8 0a             	cmp    $0xa,%eax
8010450c:	75 e2                	jne    801044f0 <getcallerpcs+0x20>
  }
  for(; i < 10; i++)
    pcs[i] = 0;
}
8010450e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104511:	c9                   	leave
80104512:	c3                   	ret
80104513:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80104518:	8d 04 81             	lea    (%ecx,%eax,4),%eax
8010451b:	83 c1 28             	add    $0x28,%ecx
8010451e:	89 ca                	mov    %ecx,%edx
80104520:	29 c2                	sub    %eax,%edx
80104522:	83 e2 04             	and    $0x4,%edx
80104525:	74 11                	je     80104538 <getcallerpcs+0x68>
    pcs[i] = 0;
80104527:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; i < 10; i++)
8010452d:	83 c0 04             	add    $0x4,%eax
80104530:	39 c1                	cmp    %eax,%ecx
80104532:	74 da                	je     8010450e <getcallerpcs+0x3e>
80104534:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    pcs[i] = 0;
80104538:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; i < 10; i++)
8010453e:	83 c0 08             	add    $0x8,%eax
    pcs[i] = 0;
80104541:	c7 40 fc 00 00 00 00 	movl   $0x0,-0x4(%eax)
  for(; i < 10; i++)
80104548:	39 c1                	cmp    %eax,%ecx
8010454a:	75 ec                	jne    80104538 <getcallerpcs+0x68>
8010454c:	eb c0                	jmp    8010450e <getcallerpcs+0x3e>
8010454e:	66 90                	xchg   %ax,%ax

80104550 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
80104550:	55                   	push   %ebp
80104551:	89 e5                	mov    %esp,%ebp
80104553:	53                   	push   %ebx
80104554:	83 ec 04             	sub    $0x4,%esp
80104557:	9c                   	pushf
80104558:	5b                   	pop    %ebx
  asm volatile("cli");
80104559:	fa                   	cli
  int eflags;

  eflags = readeflags();
  cli();
  if(mycpu()->ncli == 0)
8010455a:	e8 f1 f3 ff ff       	call   80103950 <mycpu>
8010455f:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
80104565:	85 c0                	test   %eax,%eax
80104567:	74 17                	je     80104580 <pushcli+0x30>
    mycpu()->intena = eflags & FL_IF;
  mycpu()->ncli += 1;
80104569:	e8 e2 f3 ff ff       	call   80103950 <mycpu>
8010456e:	83 80 a4 00 00 00 01 	addl   $0x1,0xa4(%eax)
}
80104575:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104578:	c9                   	leave
80104579:	c3                   	ret
8010457a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    mycpu()->intena = eflags & FL_IF;
80104580:	e8 cb f3 ff ff       	call   80103950 <mycpu>
80104585:	81 e3 00 02 00 00    	and    $0x200,%ebx
8010458b:	89 98 a8 00 00 00    	mov    %ebx,0xa8(%eax)
80104591:	eb d6                	jmp    80104569 <pushcli+0x19>
80104593:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010459a:	00 
8010459b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

801045a0 <popcli>:

void
popcli(void)
{
801045a0:	55                   	push   %ebp
801045a1:	89 e5                	mov    %esp,%ebp
801045a3:	83 ec 08             	sub    $0x8,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
801045a6:	9c                   	pushf
801045a7:	58                   	pop    %eax
  if(readeflags()&FL_IF)
801045a8:	f6 c4 02             	test   $0x2,%ah
801045ab:	75 35                	jne    801045e2 <popcli+0x42>
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
801045ad:	e8 9e f3 ff ff       	call   80103950 <mycpu>
801045b2:	83 a8 a4 00 00 00 01 	subl   $0x1,0xa4(%eax)
801045b9:	78 34                	js     801045ef <popcli+0x4f>
    panic("popcli");
  if(mycpu()->ncli == 0 && mycpu()->intena)
801045bb:	e8 90 f3 ff ff       	call   80103950 <mycpu>
801045c0:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
801045c6:	85 d2                	test   %edx,%edx
801045c8:	74 06                	je     801045d0 <popcli+0x30>
    sti();
}
801045ca:	c9                   	leave
801045cb:	c3                   	ret
801045cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(mycpu()->ncli == 0 && mycpu()->intena)
801045d0:	e8 7b f3 ff ff       	call   80103950 <mycpu>
801045d5:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
801045db:	85 c0                	test   %eax,%eax
801045dd:	74 eb                	je     801045ca <popcli+0x2a>
  asm volatile("sti");
801045df:	fb                   	sti
}
801045e0:	c9                   	leave
801045e1:	c3                   	ret
    panic("popcli - interruptible");
801045e2:	83 ec 0c             	sub    $0xc,%esp
801045e5:	68 a3 85 10 80       	push   $0x801085a3
801045ea:	e8 91 bd ff ff       	call   80100380 <panic>
    panic("popcli");
801045ef:	83 ec 0c             	sub    $0xc,%esp
801045f2:	68 ba 85 10 80       	push   $0x801085ba
801045f7:	e8 84 bd ff ff       	call   80100380 <panic>
801045fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104600 <holding>:
{
80104600:	55                   	push   %ebp
80104601:	89 e5                	mov    %esp,%ebp
80104603:	56                   	push   %esi
80104604:	53                   	push   %ebx
80104605:	8b 75 08             	mov    0x8(%ebp),%esi
80104608:	31 db                	xor    %ebx,%ebx
  pushcli();
8010460a:	e8 41 ff ff ff       	call   80104550 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
8010460f:	8b 06                	mov    (%esi),%eax
80104611:	85 c0                	test   %eax,%eax
80104613:	75 0b                	jne    80104620 <holding+0x20>
  popcli();
80104615:	e8 86 ff ff ff       	call   801045a0 <popcli>
}
8010461a:	89 d8                	mov    %ebx,%eax
8010461c:	5b                   	pop    %ebx
8010461d:	5e                   	pop    %esi
8010461e:	5d                   	pop    %ebp
8010461f:	c3                   	ret
  r = lock->locked && lock->cpu == mycpu();
80104620:	8b 5e 08             	mov    0x8(%esi),%ebx
80104623:	e8 28 f3 ff ff       	call   80103950 <mycpu>
80104628:	39 c3                	cmp    %eax,%ebx
8010462a:	0f 94 c3             	sete   %bl
  popcli();
8010462d:	e8 6e ff ff ff       	call   801045a0 <popcli>
  r = lock->locked && lock->cpu == mycpu();
80104632:	0f b6 db             	movzbl %bl,%ebx
}
80104635:	89 d8                	mov    %ebx,%eax
80104637:	5b                   	pop    %ebx
80104638:	5e                   	pop    %esi
80104639:	5d                   	pop    %ebp
8010463a:	c3                   	ret
8010463b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80104640 <release>:
{
80104640:	55                   	push   %ebp
80104641:	89 e5                	mov    %esp,%ebp
80104643:	56                   	push   %esi
80104644:	53                   	push   %ebx
80104645:	8b 5d 08             	mov    0x8(%ebp),%ebx
  pushcli();
80104648:	e8 03 ff ff ff       	call   80104550 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
8010464d:	8b 03                	mov    (%ebx),%eax
8010464f:	85 c0                	test   %eax,%eax
80104651:	75 15                	jne    80104668 <release+0x28>
  popcli();
80104653:	e8 48 ff ff ff       	call   801045a0 <popcli>
    panic("release");
80104658:	83 ec 0c             	sub    $0xc,%esp
8010465b:	68 c1 85 10 80       	push   $0x801085c1
80104660:	e8 1b bd ff ff       	call   80100380 <panic>
80104665:	8d 76 00             	lea    0x0(%esi),%esi
  r = lock->locked && lock->cpu == mycpu();
80104668:	8b 73 08             	mov    0x8(%ebx),%esi
8010466b:	e8 e0 f2 ff ff       	call   80103950 <mycpu>
80104670:	39 c6                	cmp    %eax,%esi
80104672:	75 df                	jne    80104653 <release+0x13>
  popcli();
80104674:	e8 27 ff ff ff       	call   801045a0 <popcli>
  lk->pcs[0] = 0;
80104679:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  lk->cpu = 0;
80104680:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
  __sync_synchronize();
80104687:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );
8010468c:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
}
80104692:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104695:	5b                   	pop    %ebx
80104696:	5e                   	pop    %esi
80104697:	5d                   	pop    %ebp
  popcli();
80104698:	e9 03 ff ff ff       	jmp    801045a0 <popcli>
8010469d:	8d 76 00             	lea    0x0(%esi),%esi

801046a0 <acquire>:
{
801046a0:	55                   	push   %ebp
801046a1:	89 e5                	mov    %esp,%ebp
801046a3:	53                   	push   %ebx
801046a4:	83 ec 04             	sub    $0x4,%esp
  pushcli(); // disable interrupts to avoid deadlock.
801046a7:	e8 a4 fe ff ff       	call   80104550 <pushcli>
  if(holding(lk))
801046ac:	8b 5d 08             	mov    0x8(%ebp),%ebx
  pushcli();
801046af:	e8 9c fe ff ff       	call   80104550 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
801046b4:	8b 03                	mov    (%ebx),%eax
801046b6:	85 c0                	test   %eax,%eax
801046b8:	0f 85 b2 00 00 00    	jne    80104770 <acquire+0xd0>
  popcli();
801046be:	e8 dd fe ff ff       	call   801045a0 <popcli>
  asm volatile("lock; xchgl %0, %1" :
801046c3:	b9 01 00 00 00       	mov    $0x1,%ecx
801046c8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801046cf:	00 
  while(xchg(&lk->locked, 1) != 0)
801046d0:	8b 55 08             	mov    0x8(%ebp),%edx
801046d3:	89 c8                	mov    %ecx,%eax
801046d5:	f0 87 02             	lock xchg %eax,(%edx)
801046d8:	85 c0                	test   %eax,%eax
801046da:	75 f4                	jne    801046d0 <acquire+0x30>
  __sync_synchronize();
801046dc:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  lk->cpu = mycpu();
801046e1:	8b 5d 08             	mov    0x8(%ebp),%ebx
801046e4:	e8 67 f2 ff ff       	call   80103950 <mycpu>
  getcallerpcs(&lk, lk->pcs);
801046e9:	8b 4d 08             	mov    0x8(%ebp),%ecx
  for(i = 0; i < 10; i++){
801046ec:	31 d2                	xor    %edx,%edx
  lk->cpu = mycpu();
801046ee:	89 43 08             	mov    %eax,0x8(%ebx)
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
801046f1:	8d 85 00 00 00 80    	lea    -0x80000000(%ebp),%eax
801046f7:	3d fe ff ff 7f       	cmp    $0x7ffffffe,%eax
801046fc:	77 32                	ja     80104730 <acquire+0x90>
  ebp = (uint*)v - 2;
801046fe:	89 e8                	mov    %ebp,%eax
80104700:	eb 14                	jmp    80104716 <acquire+0x76>
80104702:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80104708:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
8010470e:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
80104714:	77 1a                	ja     80104730 <acquire+0x90>
    pcs[i] = ebp[1];     // saved %eip
80104716:	8b 58 04             	mov    0x4(%eax),%ebx
80104719:	89 5c 91 0c          	mov    %ebx,0xc(%ecx,%edx,4)
  for(i = 0; i < 10; i++){
8010471d:	83 c2 01             	add    $0x1,%edx
    ebp = (uint*)ebp[0]; // saved %ebp
80104720:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
80104722:	83 fa 0a             	cmp    $0xa,%edx
80104725:	75 e1                	jne    80104708 <acquire+0x68>
}
80104727:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010472a:	c9                   	leave
8010472b:	c3                   	ret
8010472c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104730:	8d 44 91 0c          	lea    0xc(%ecx,%edx,4),%eax
80104734:	83 c1 34             	add    $0x34,%ecx
80104737:	89 ca                	mov    %ecx,%edx
80104739:	29 c2                	sub    %eax,%edx
8010473b:	83 e2 04             	and    $0x4,%edx
8010473e:	74 10                	je     80104750 <acquire+0xb0>
    pcs[i] = 0;
80104740:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; i < 10; i++)
80104746:	83 c0 04             	add    $0x4,%eax
80104749:	39 c1                	cmp    %eax,%ecx
8010474b:	74 da                	je     80104727 <acquire+0x87>
8010474d:	8d 76 00             	lea    0x0(%esi),%esi
    pcs[i] = 0;
80104750:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; i < 10; i++)
80104756:	83 c0 08             	add    $0x8,%eax
    pcs[i] = 0;
80104759:	c7 40 fc 00 00 00 00 	movl   $0x0,-0x4(%eax)
  for(; i < 10; i++)
80104760:	39 c1                	cmp    %eax,%ecx
80104762:	75 ec                	jne    80104750 <acquire+0xb0>
80104764:	eb c1                	jmp    80104727 <acquire+0x87>
80104766:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010476d:	00 
8010476e:	66 90                	xchg   %ax,%ax
  r = lock->locked && lock->cpu == mycpu();
80104770:	8b 5b 08             	mov    0x8(%ebx),%ebx
80104773:	e8 d8 f1 ff ff       	call   80103950 <mycpu>
80104778:	39 c3                	cmp    %eax,%ebx
8010477a:	0f 85 3e ff ff ff    	jne    801046be <acquire+0x1e>
  popcli();
80104780:	e8 1b fe ff ff       	call   801045a0 <popcli>
    panic("acquire");
80104785:	83 ec 0c             	sub    $0xc,%esp
80104788:	68 c9 85 10 80       	push   $0x801085c9
8010478d:	e8 ee bb ff ff       	call   80100380 <panic>
80104792:	66 90                	xchg   %ax,%ax
80104794:	66 90                	xchg   %ax,%ax
80104796:	66 90                	xchg   %ax,%ax
80104798:	66 90                	xchg   %ax,%ax
8010479a:	66 90                	xchg   %ax,%ax
8010479c:	66 90                	xchg   %ax,%ax
8010479e:	66 90                	xchg   %ax,%ax

801047a0 <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
801047a0:	55                   	push   %ebp
801047a1:	89 e5                	mov    %esp,%ebp
801047a3:	57                   	push   %edi
801047a4:	8b 55 08             	mov    0x8(%ebp),%edx
801047a7:	8b 4d 10             	mov    0x10(%ebp),%ecx
  if ((int)dst%4 == 0 && n%4 == 0){
801047aa:	89 d0                	mov    %edx,%eax
801047ac:	09 c8                	or     %ecx,%eax
801047ae:	a8 03                	test   $0x3,%al
801047b0:	75 1e                	jne    801047d0 <memset+0x30>
    c &= 0xFF;
801047b2:	0f b6 45 0c          	movzbl 0xc(%ebp),%eax
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
801047b6:	c1 e9 02             	shr    $0x2,%ecx
  asm volatile("cld; rep stosl" :
801047b9:	89 d7                	mov    %edx,%edi
801047bb:	69 c0 01 01 01 01    	imul   $0x1010101,%eax,%eax
801047c1:	fc                   	cld
801047c2:	f3 ab                	rep stos %eax,%es:(%edi)
  } else
    stosb(dst, c, n);
  return dst;
}
801047c4:	8b 7d fc             	mov    -0x4(%ebp),%edi
801047c7:	89 d0                	mov    %edx,%eax
801047c9:	c9                   	leave
801047ca:	c3                   	ret
801047cb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  asm volatile("cld; rep stosb" :
801047d0:	8b 45 0c             	mov    0xc(%ebp),%eax
801047d3:	89 d7                	mov    %edx,%edi
801047d5:	fc                   	cld
801047d6:	f3 aa                	rep stos %al,%es:(%edi)
801047d8:	8b 7d fc             	mov    -0x4(%ebp),%edi
801047db:	89 d0                	mov    %edx,%eax
801047dd:	c9                   	leave
801047de:	c3                   	ret
801047df:	90                   	nop

801047e0 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
801047e0:	55                   	push   %ebp
801047e1:	89 e5                	mov    %esp,%ebp
801047e3:	56                   	push   %esi
801047e4:	8b 75 10             	mov    0x10(%ebp),%esi
801047e7:	8b 45 08             	mov    0x8(%ebp),%eax
801047ea:	53                   	push   %ebx
801047eb:	8b 55 0c             	mov    0xc(%ebp),%edx
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
801047ee:	85 f6                	test   %esi,%esi
801047f0:	74 2e                	je     80104820 <memcmp+0x40>
801047f2:	01 c6                	add    %eax,%esi
801047f4:	eb 14                	jmp    8010480a <memcmp+0x2a>
801047f6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801047fd:	00 
801047fe:	66 90                	xchg   %ax,%ax
    if(*s1 != *s2)
      return *s1 - *s2;
    s1++, s2++;
80104800:	83 c0 01             	add    $0x1,%eax
80104803:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0){
80104806:	39 f0                	cmp    %esi,%eax
80104808:	74 16                	je     80104820 <memcmp+0x40>
    if(*s1 != *s2)
8010480a:	0f b6 08             	movzbl (%eax),%ecx
8010480d:	0f b6 1a             	movzbl (%edx),%ebx
80104810:	38 d9                	cmp    %bl,%cl
80104812:	74 ec                	je     80104800 <memcmp+0x20>
      return *s1 - *s2;
80104814:	0f b6 c1             	movzbl %cl,%eax
80104817:	29 d8                	sub    %ebx,%eax
  }

  return 0;
}
80104819:	5b                   	pop    %ebx
8010481a:	5e                   	pop    %esi
8010481b:	5d                   	pop    %ebp
8010481c:	c3                   	ret
8010481d:	8d 76 00             	lea    0x0(%esi),%esi
80104820:	5b                   	pop    %ebx
  return 0;
80104821:	31 c0                	xor    %eax,%eax
}
80104823:	5e                   	pop    %esi
80104824:	5d                   	pop    %ebp
80104825:	c3                   	ret
80104826:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010482d:	00 
8010482e:	66 90                	xchg   %ax,%ax

80104830 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
80104830:	55                   	push   %ebp
80104831:	89 e5                	mov    %esp,%ebp
80104833:	57                   	push   %edi
80104834:	8b 55 08             	mov    0x8(%ebp),%edx
80104837:	8b 45 10             	mov    0x10(%ebp),%eax
8010483a:	56                   	push   %esi
8010483b:	8b 75 0c             	mov    0xc(%ebp),%esi
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
8010483e:	39 d6                	cmp    %edx,%esi
80104840:	73 26                	jae    80104868 <memmove+0x38>
80104842:	8d 0c 06             	lea    (%esi,%eax,1),%ecx
80104845:	39 ca                	cmp    %ecx,%edx
80104847:	73 1f                	jae    80104868 <memmove+0x38>
    s += n;
    d += n;
    while(n-- > 0)
80104849:	85 c0                	test   %eax,%eax
8010484b:	74 0f                	je     8010485c <memmove+0x2c>
8010484d:	83 e8 01             	sub    $0x1,%eax
      *--d = *--s;
80104850:	0f b6 0c 06          	movzbl (%esi,%eax,1),%ecx
80104854:	88 0c 02             	mov    %cl,(%edx,%eax,1)
    while(n-- > 0)
80104857:	83 e8 01             	sub    $0x1,%eax
8010485a:	73 f4                	jae    80104850 <memmove+0x20>
  } else
    while(n-- > 0)
      *d++ = *s++;

  return dst;
}
8010485c:	5e                   	pop    %esi
8010485d:	89 d0                	mov    %edx,%eax
8010485f:	5f                   	pop    %edi
80104860:	5d                   	pop    %ebp
80104861:	c3                   	ret
80104862:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    while(n-- > 0)
80104868:	8d 0c 06             	lea    (%esi,%eax,1),%ecx
8010486b:	89 d7                	mov    %edx,%edi
8010486d:	85 c0                	test   %eax,%eax
8010486f:	74 eb                	je     8010485c <memmove+0x2c>
80104871:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      *d++ = *s++;
80104878:	a4                   	movsb  %ds:(%esi),%es:(%edi)
    while(n-- > 0)
80104879:	39 ce                	cmp    %ecx,%esi
8010487b:	75 fb                	jne    80104878 <memmove+0x48>
}
8010487d:	5e                   	pop    %esi
8010487e:	89 d0                	mov    %edx,%eax
80104880:	5f                   	pop    %edi
80104881:	5d                   	pop    %ebp
80104882:	c3                   	ret
80104883:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010488a:	00 
8010488b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80104890 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
  return memmove(dst, src, n);
80104890:	eb 9e                	jmp    80104830 <memmove>
80104892:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104899:	00 
8010489a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801048a0 <strncmp>:
}

int
strncmp(const char *p, const char *q, uint n)
{
801048a0:	55                   	push   %ebp
801048a1:	89 e5                	mov    %esp,%ebp
801048a3:	53                   	push   %ebx
801048a4:	8b 55 10             	mov    0x10(%ebp),%edx
801048a7:	8b 45 08             	mov    0x8(%ebp),%eax
801048aa:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(n > 0 && *p && *p == *q)
801048ad:	85 d2                	test   %edx,%edx
801048af:	75 16                	jne    801048c7 <strncmp+0x27>
801048b1:	eb 2d                	jmp    801048e0 <strncmp+0x40>
801048b3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
801048b8:	3a 19                	cmp    (%ecx),%bl
801048ba:	75 12                	jne    801048ce <strncmp+0x2e>
    n--, p++, q++;
801048bc:	83 c0 01             	add    $0x1,%eax
801048bf:	83 c1 01             	add    $0x1,%ecx
  while(n > 0 && *p && *p == *q)
801048c2:	83 ea 01             	sub    $0x1,%edx
801048c5:	74 19                	je     801048e0 <strncmp+0x40>
801048c7:	0f b6 18             	movzbl (%eax),%ebx
801048ca:	84 db                	test   %bl,%bl
801048cc:	75 ea                	jne    801048b8 <strncmp+0x18>
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
801048ce:	0f b6 00             	movzbl (%eax),%eax
801048d1:	0f b6 11             	movzbl (%ecx),%edx
}
801048d4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801048d7:	c9                   	leave
  return (uchar)*p - (uchar)*q;
801048d8:	29 d0                	sub    %edx,%eax
}
801048da:	c3                   	ret
801048db:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
801048e0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    return 0;
801048e3:	31 c0                	xor    %eax,%eax
}
801048e5:	c9                   	leave
801048e6:	c3                   	ret
801048e7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801048ee:	00 
801048ef:	90                   	nop

801048f0 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
801048f0:	55                   	push   %ebp
801048f1:	89 e5                	mov    %esp,%ebp
801048f3:	57                   	push   %edi
801048f4:	56                   	push   %esi
801048f5:	8b 75 08             	mov    0x8(%ebp),%esi
801048f8:	53                   	push   %ebx
801048f9:	8b 55 10             	mov    0x10(%ebp),%edx
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
801048fc:	89 f0                	mov    %esi,%eax
801048fe:	eb 15                	jmp    80104915 <strncpy+0x25>
80104900:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
80104904:	8b 7d 0c             	mov    0xc(%ebp),%edi
80104907:	83 c0 01             	add    $0x1,%eax
8010490a:	0f b6 4f ff          	movzbl -0x1(%edi),%ecx
8010490e:	88 48 ff             	mov    %cl,-0x1(%eax)
80104911:	84 c9                	test   %cl,%cl
80104913:	74 13                	je     80104928 <strncpy+0x38>
80104915:	89 d3                	mov    %edx,%ebx
80104917:	83 ea 01             	sub    $0x1,%edx
8010491a:	85 db                	test   %ebx,%ebx
8010491c:	7f e2                	jg     80104900 <strncpy+0x10>
    ;
  while(n-- > 0)
    *s++ = 0;
  return os;
}
8010491e:	5b                   	pop    %ebx
8010491f:	89 f0                	mov    %esi,%eax
80104921:	5e                   	pop    %esi
80104922:	5f                   	pop    %edi
80104923:	5d                   	pop    %ebp
80104924:	c3                   	ret
80104925:	8d 76 00             	lea    0x0(%esi),%esi
  while(n-- > 0)
80104928:	8d 0c 18             	lea    (%eax,%ebx,1),%ecx
8010492b:	83 e9 01             	sub    $0x1,%ecx
8010492e:	85 d2                	test   %edx,%edx
80104930:	74 ec                	je     8010491e <strncpy+0x2e>
80104932:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    *s++ = 0;
80104938:	83 c0 01             	add    $0x1,%eax
8010493b:	89 ca                	mov    %ecx,%edx
8010493d:	c6 40 ff 00          	movb   $0x0,-0x1(%eax)
  while(n-- > 0)
80104941:	29 c2                	sub    %eax,%edx
80104943:	85 d2                	test   %edx,%edx
80104945:	7f f1                	jg     80104938 <strncpy+0x48>
}
80104947:	5b                   	pop    %ebx
80104948:	89 f0                	mov    %esi,%eax
8010494a:	5e                   	pop    %esi
8010494b:	5f                   	pop    %edi
8010494c:	5d                   	pop    %ebp
8010494d:	c3                   	ret
8010494e:	66 90                	xchg   %ax,%ax

80104950 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
80104950:	55                   	push   %ebp
80104951:	89 e5                	mov    %esp,%ebp
80104953:	56                   	push   %esi
80104954:	8b 55 10             	mov    0x10(%ebp),%edx
80104957:	8b 75 08             	mov    0x8(%ebp),%esi
8010495a:	53                   	push   %ebx
8010495b:	8b 45 0c             	mov    0xc(%ebp),%eax
  char *os;

  os = s;
  if(n <= 0)
8010495e:	85 d2                	test   %edx,%edx
80104960:	7e 25                	jle    80104987 <safestrcpy+0x37>
80104962:	8d 5c 10 ff          	lea    -0x1(%eax,%edx,1),%ebx
80104966:	89 f2                	mov    %esi,%edx
80104968:	eb 16                	jmp    80104980 <safestrcpy+0x30>
8010496a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
80104970:	0f b6 08             	movzbl (%eax),%ecx
80104973:	83 c0 01             	add    $0x1,%eax
80104976:	83 c2 01             	add    $0x1,%edx
80104979:	88 4a ff             	mov    %cl,-0x1(%edx)
8010497c:	84 c9                	test   %cl,%cl
8010497e:	74 04                	je     80104984 <safestrcpy+0x34>
80104980:	39 d8                	cmp    %ebx,%eax
80104982:	75 ec                	jne    80104970 <safestrcpy+0x20>
    ;
  *s = 0;
80104984:	c6 02 00             	movb   $0x0,(%edx)
  return os;
}
80104987:	89 f0                	mov    %esi,%eax
80104989:	5b                   	pop    %ebx
8010498a:	5e                   	pop    %esi
8010498b:	5d                   	pop    %ebp
8010498c:	c3                   	ret
8010498d:	8d 76 00             	lea    0x0(%esi),%esi

80104990 <strlen>:

int
strlen(const char *s)
{
80104990:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
80104991:	31 c0                	xor    %eax,%eax
{
80104993:	89 e5                	mov    %esp,%ebp
80104995:	8b 55 08             	mov    0x8(%ebp),%edx
  for(n = 0; s[n]; n++)
80104998:	80 3a 00             	cmpb   $0x0,(%edx)
8010499b:	74 0c                	je     801049a9 <strlen+0x19>
8010499d:	8d 76 00             	lea    0x0(%esi),%esi
801049a0:	83 c0 01             	add    $0x1,%eax
801049a3:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
801049a7:	75 f7                	jne    801049a0 <strlen+0x10>
    ;
  return n;
}
801049a9:	5d                   	pop    %ebp
801049aa:	c3                   	ret

801049ab <swtch>:
# a struct context, and save its address in *old.
# Switch stacks to new and pop previously-saved registers.

.globl swtch
swtch:
  movl 4(%esp), %eax
801049ab:	8b 44 24 04          	mov    0x4(%esp),%eax
  movl 8(%esp), %edx
801049af:	8b 54 24 08          	mov    0x8(%esp),%edx

  # Save old callee-saved registers
  pushl %ebp
801049b3:	55                   	push   %ebp
  pushl %ebx
801049b4:	53                   	push   %ebx
  pushl %esi
801049b5:	56                   	push   %esi
  pushl %edi
801049b6:	57                   	push   %edi

  # Switch stacks
  movl %esp, (%eax)
801049b7:	89 20                	mov    %esp,(%eax)
  movl %edx, %esp
801049b9:	89 d4                	mov    %edx,%esp

  # Load new callee-saved registers
  popl %edi
801049bb:	5f                   	pop    %edi
  popl %esi
801049bc:	5e                   	pop    %esi
  popl %ebx
801049bd:	5b                   	pop    %ebx
  popl %ebp
801049be:	5d                   	pop    %ebp
  ret
801049bf:	c3                   	ret

801049c0 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
801049c0:	55                   	push   %ebp
801049c1:	89 e5                	mov    %esp,%ebp
801049c3:	53                   	push   %ebx
801049c4:	83 ec 04             	sub    $0x4,%esp
801049c7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *curproc = myproc();
801049ca:	e8 01 f0 ff ff       	call   801039d0 <myproc>

  if(addr >= curproc->sz || addr+4 > curproc->sz)
801049cf:	8b 00                	mov    (%eax),%eax
801049d1:	39 c3                	cmp    %eax,%ebx
801049d3:	73 1b                	jae    801049f0 <fetchint+0x30>
801049d5:	8d 53 04             	lea    0x4(%ebx),%edx
801049d8:	39 d0                	cmp    %edx,%eax
801049da:	72 14                	jb     801049f0 <fetchint+0x30>
    return -1;
  *ip = *(int*)(addr);
801049dc:	8b 45 0c             	mov    0xc(%ebp),%eax
801049df:	8b 13                	mov    (%ebx),%edx
801049e1:	89 10                	mov    %edx,(%eax)
  return 0;
801049e3:	31 c0                	xor    %eax,%eax
}
801049e5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801049e8:	c9                   	leave
801049e9:	c3                   	ret
801049ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
801049f0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801049f5:	eb ee                	jmp    801049e5 <fetchint+0x25>
801049f7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801049fe:	00 
801049ff:	90                   	nop

80104a00 <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
80104a00:	55                   	push   %ebp
80104a01:	89 e5                	mov    %esp,%ebp
80104a03:	53                   	push   %ebx
80104a04:	83 ec 04             	sub    $0x4,%esp
80104a07:	8b 5d 08             	mov    0x8(%ebp),%ebx
  char *s, *ep;
  struct proc *curproc = myproc();
80104a0a:	e8 c1 ef ff ff       	call   801039d0 <myproc>

  if(addr >= curproc->sz)
80104a0f:	3b 18                	cmp    (%eax),%ebx
80104a11:	73 2d                	jae    80104a40 <fetchstr+0x40>
    return -1;
  *pp = (char*)addr;
80104a13:	8b 55 0c             	mov    0xc(%ebp),%edx
80104a16:	89 1a                	mov    %ebx,(%edx)
  ep = (char*)curproc->sz;
80104a18:	8b 10                	mov    (%eax),%edx
  for(s = *pp; s < ep; s++){
80104a1a:	39 d3                	cmp    %edx,%ebx
80104a1c:	73 22                	jae    80104a40 <fetchstr+0x40>
80104a1e:	89 d8                	mov    %ebx,%eax
80104a20:	eb 0d                	jmp    80104a2f <fetchstr+0x2f>
80104a22:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104a28:	83 c0 01             	add    $0x1,%eax
80104a2b:	39 d0                	cmp    %edx,%eax
80104a2d:	73 11                	jae    80104a40 <fetchstr+0x40>
    if(*s == 0)
80104a2f:	80 38 00             	cmpb   $0x0,(%eax)
80104a32:	75 f4                	jne    80104a28 <fetchstr+0x28>
      return s - *pp;
80104a34:	29 d8                	sub    %ebx,%eax
  }
  return -1;
}
80104a36:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104a39:	c9                   	leave
80104a3a:	c3                   	ret
80104a3b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80104a40:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    return -1;
80104a43:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104a48:	c9                   	leave
80104a49:	c3                   	ret
80104a4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104a50 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
80104a50:	55                   	push   %ebp
80104a51:	89 e5                	mov    %esp,%ebp
80104a53:	56                   	push   %esi
80104a54:	53                   	push   %ebx
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104a55:	e8 76 ef ff ff       	call   801039d0 <myproc>
80104a5a:	8b 55 08             	mov    0x8(%ebp),%edx
80104a5d:	8b 40 18             	mov    0x18(%eax),%eax
80104a60:	8b 40 44             	mov    0x44(%eax),%eax
80104a63:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
80104a66:	e8 65 ef ff ff       	call   801039d0 <myproc>
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104a6b:	8d 73 04             	lea    0x4(%ebx),%esi
  if(addr >= curproc->sz || addr+4 > curproc->sz)
80104a6e:	8b 00                	mov    (%eax),%eax
80104a70:	39 c6                	cmp    %eax,%esi
80104a72:	73 1c                	jae    80104a90 <argint+0x40>
80104a74:	8d 53 08             	lea    0x8(%ebx),%edx
80104a77:	39 d0                	cmp    %edx,%eax
80104a79:	72 15                	jb     80104a90 <argint+0x40>
  *ip = *(int*)(addr);
80104a7b:	8b 45 0c             	mov    0xc(%ebp),%eax
80104a7e:	8b 53 04             	mov    0x4(%ebx),%edx
80104a81:	89 10                	mov    %edx,(%eax)
  return 0;
80104a83:	31 c0                	xor    %eax,%eax
}
80104a85:	5b                   	pop    %ebx
80104a86:	5e                   	pop    %esi
80104a87:	5d                   	pop    %ebp
80104a88:	c3                   	ret
80104a89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80104a90:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104a95:	eb ee                	jmp    80104a85 <argint+0x35>
80104a97:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104a9e:	00 
80104a9f:	90                   	nop

80104aa0 <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
80104aa0:	55                   	push   %ebp
80104aa1:	89 e5                	mov    %esp,%ebp
80104aa3:	57                   	push   %edi
80104aa4:	56                   	push   %esi
80104aa5:	53                   	push   %ebx
80104aa6:	83 ec 0c             	sub    $0xc,%esp
  int i;
  struct proc *curproc = myproc();
80104aa9:	e8 22 ef ff ff       	call   801039d0 <myproc>
80104aae:	89 c6                	mov    %eax,%esi
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104ab0:	e8 1b ef ff ff       	call   801039d0 <myproc>
80104ab5:	8b 55 08             	mov    0x8(%ebp),%edx
80104ab8:	8b 40 18             	mov    0x18(%eax),%eax
80104abb:	8b 40 44             	mov    0x44(%eax),%eax
80104abe:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
80104ac1:	e8 0a ef ff ff       	call   801039d0 <myproc>
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104ac6:	8d 7b 04             	lea    0x4(%ebx),%edi
  if(addr >= curproc->sz || addr+4 > curproc->sz)
80104ac9:	8b 00                	mov    (%eax),%eax
80104acb:	39 c7                	cmp    %eax,%edi
80104acd:	73 31                	jae    80104b00 <argptr+0x60>
80104acf:	8d 4b 08             	lea    0x8(%ebx),%ecx
80104ad2:	39 c8                	cmp    %ecx,%eax
80104ad4:	72 2a                	jb     80104b00 <argptr+0x60>
 
  if(argint(n, &i) < 0)
    return -1;
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
80104ad6:	8b 55 10             	mov    0x10(%ebp),%edx
  *ip = *(int*)(addr);
80104ad9:	8b 43 04             	mov    0x4(%ebx),%eax
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
80104adc:	85 d2                	test   %edx,%edx
80104ade:	78 20                	js     80104b00 <argptr+0x60>
80104ae0:	8b 16                	mov    (%esi),%edx
80104ae2:	39 d0                	cmp    %edx,%eax
80104ae4:	73 1a                	jae    80104b00 <argptr+0x60>
80104ae6:	8b 5d 10             	mov    0x10(%ebp),%ebx
80104ae9:	01 c3                	add    %eax,%ebx
80104aeb:	39 da                	cmp    %ebx,%edx
80104aed:	72 11                	jb     80104b00 <argptr+0x60>
    return -1;
  *pp = (char*)i;
80104aef:	8b 55 0c             	mov    0xc(%ebp),%edx
80104af2:	89 02                	mov    %eax,(%edx)
  return 0;
80104af4:	31 c0                	xor    %eax,%eax
}
80104af6:	83 c4 0c             	add    $0xc,%esp
80104af9:	5b                   	pop    %ebx
80104afa:	5e                   	pop    %esi
80104afb:	5f                   	pop    %edi
80104afc:	5d                   	pop    %ebp
80104afd:	c3                   	ret
80104afe:	66 90                	xchg   %ax,%ax
    return -1;
80104b00:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104b05:	eb ef                	jmp    80104af6 <argptr+0x56>
80104b07:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104b0e:	00 
80104b0f:	90                   	nop

80104b10 <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
80104b10:	55                   	push   %ebp
80104b11:	89 e5                	mov    %esp,%ebp
80104b13:	56                   	push   %esi
80104b14:	53                   	push   %ebx
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104b15:	e8 b6 ee ff ff       	call   801039d0 <myproc>
80104b1a:	8b 55 08             	mov    0x8(%ebp),%edx
80104b1d:	8b 40 18             	mov    0x18(%eax),%eax
80104b20:	8b 40 44             	mov    0x44(%eax),%eax
80104b23:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
80104b26:	e8 a5 ee ff ff       	call   801039d0 <myproc>
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104b2b:	8d 73 04             	lea    0x4(%ebx),%esi
  if(addr >= curproc->sz || addr+4 > curproc->sz)
80104b2e:	8b 00                	mov    (%eax),%eax
80104b30:	39 c6                	cmp    %eax,%esi
80104b32:	73 44                	jae    80104b78 <argstr+0x68>
80104b34:	8d 53 08             	lea    0x8(%ebx),%edx
80104b37:	39 d0                	cmp    %edx,%eax
80104b39:	72 3d                	jb     80104b78 <argstr+0x68>
  *ip = *(int*)(addr);
80104b3b:	8b 5b 04             	mov    0x4(%ebx),%ebx
  struct proc *curproc = myproc();
80104b3e:	e8 8d ee ff ff       	call   801039d0 <myproc>
  if(addr >= curproc->sz)
80104b43:	3b 18                	cmp    (%eax),%ebx
80104b45:	73 31                	jae    80104b78 <argstr+0x68>
  *pp = (char*)addr;
80104b47:	8b 55 0c             	mov    0xc(%ebp),%edx
80104b4a:	89 1a                	mov    %ebx,(%edx)
  ep = (char*)curproc->sz;
80104b4c:	8b 10                	mov    (%eax),%edx
  for(s = *pp; s < ep; s++){
80104b4e:	39 d3                	cmp    %edx,%ebx
80104b50:	73 26                	jae    80104b78 <argstr+0x68>
80104b52:	89 d8                	mov    %ebx,%eax
80104b54:	eb 11                	jmp    80104b67 <argstr+0x57>
80104b56:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104b5d:	00 
80104b5e:	66 90                	xchg   %ax,%ax
80104b60:	83 c0 01             	add    $0x1,%eax
80104b63:	39 d0                	cmp    %edx,%eax
80104b65:	73 11                	jae    80104b78 <argstr+0x68>
    if(*s == 0)
80104b67:	80 38 00             	cmpb   $0x0,(%eax)
80104b6a:	75 f4                	jne    80104b60 <argstr+0x50>
      return s - *pp;
80104b6c:	29 d8                	sub    %ebx,%eax
  int addr;
  if(argint(n, &addr) < 0)
    return -1;
  return fetchstr(addr, pp);
}
80104b6e:	5b                   	pop    %ebx
80104b6f:	5e                   	pop    %esi
80104b70:	5d                   	pop    %ebp
80104b71:	c3                   	ret
80104b72:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104b78:	5b                   	pop    %ebx
    return -1;
80104b79:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104b7e:	5e                   	pop    %esi
80104b7f:	5d                   	pop    %ebp
80104b80:	c3                   	ret
80104b81:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104b88:	00 
80104b89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104b90 <syscall>:
[SYS_removeshm] sys_removeshm,
};

void
syscall(void)
{
80104b90:	55                   	push   %ebp
80104b91:	89 e5                	mov    %esp,%ebp
80104b93:	53                   	push   %ebx
80104b94:	83 ec 04             	sub    $0x4,%esp
  int num;
  struct proc *curproc = myproc();
80104b97:	e8 34 ee ff ff       	call   801039d0 <myproc>
80104b9c:	89 c3                	mov    %eax,%ebx

  num = curproc->tf->eax;
80104b9e:	8b 40 18             	mov    0x18(%eax),%eax
80104ba1:	8b 40 1c             	mov    0x1c(%eax),%eax
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
80104ba4:	8d 50 ff             	lea    -0x1(%eax),%edx
80104ba7:	83 fa 1a             	cmp    $0x1a,%edx
80104baa:	77 24                	ja     80104bd0 <syscall+0x40>
80104bac:	8b 14 85 e0 8c 10 80 	mov    -0x7fef7320(,%eax,4),%edx
80104bb3:	85 d2                	test   %edx,%edx
80104bb5:	74 19                	je     80104bd0 <syscall+0x40>
    curproc->tf->eax = syscalls[num]();
80104bb7:	ff d2                	call   *%edx
80104bb9:	89 c2                	mov    %eax,%edx
80104bbb:	8b 43 18             	mov    0x18(%ebx),%eax
80104bbe:	89 50 1c             	mov    %edx,0x1c(%eax)
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            curproc->pid, curproc->name, num);
    curproc->tf->eax = -1;
  }
}
80104bc1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104bc4:	c9                   	leave
80104bc5:	c3                   	ret
80104bc6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104bcd:	00 
80104bce:	66 90                	xchg   %ax,%ax
    cprintf("%d %s: unknown sys call %d\n",
80104bd0:	50                   	push   %eax
            curproc->pid, curproc->name, num);
80104bd1:	8d 43 6c             	lea    0x6c(%ebx),%eax
    cprintf("%d %s: unknown sys call %d\n",
80104bd4:	50                   	push   %eax
80104bd5:	ff 73 10             	push   0x10(%ebx)
80104bd8:	68 d1 85 10 80       	push   $0x801085d1
80104bdd:	e8 ce ba ff ff       	call   801006b0 <cprintf>
    curproc->tf->eax = -1;
80104be2:	8b 43 18             	mov    0x18(%ebx),%eax
80104be5:	83 c4 10             	add    $0x10,%esp
80104be8:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
}
80104bef:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104bf2:	c9                   	leave
80104bf3:	c3                   	ret
80104bf4:	66 90                	xchg   %ax,%ax
80104bf6:	66 90                	xchg   %ax,%ax
80104bf8:	66 90                	xchg   %ax,%ax
80104bfa:	66 90                	xchg   %ax,%ax
80104bfc:	66 90                	xchg   %ax,%ax
80104bfe:	66 90                	xchg   %ax,%ax

80104c00 <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
80104c00:	55                   	push   %ebp
80104c01:	89 e5                	mov    %esp,%ebp
80104c03:	57                   	push   %edi
80104c04:	56                   	push   %esi
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80104c05:	8d 7d da             	lea    -0x26(%ebp),%edi
{
80104c08:	53                   	push   %ebx
80104c09:	83 ec 34             	sub    $0x34,%esp
80104c0c:	89 4d d0             	mov    %ecx,-0x30(%ebp)
80104c0f:	8b 4d 08             	mov    0x8(%ebp),%ecx
80104c12:	89 55 d4             	mov    %edx,-0x2c(%ebp)
80104c15:	89 4d cc             	mov    %ecx,-0x34(%ebp)
  if((dp = nameiparent(path, name)) == 0)
80104c18:	57                   	push   %edi
80104c19:	50                   	push   %eax
80104c1a:	e8 e1 d4 ff ff       	call   80102100 <nameiparent>
80104c1f:	83 c4 10             	add    $0x10,%esp
80104c22:	85 c0                	test   %eax,%eax
80104c24:	74 5e                	je     80104c84 <create+0x84>
    return 0;
  ilock(dp);
80104c26:	83 ec 0c             	sub    $0xc,%esp
80104c29:	89 c3                	mov    %eax,%ebx
80104c2b:	50                   	push   %eax
80104c2c:	e8 cf cb ff ff       	call   80101800 <ilock>

  if((ip = dirlookup(dp, name, 0)) != 0){
80104c31:	83 c4 0c             	add    $0xc,%esp
80104c34:	6a 00                	push   $0x0
80104c36:	57                   	push   %edi
80104c37:	53                   	push   %ebx
80104c38:	e8 13 d1 ff ff       	call   80101d50 <dirlookup>
80104c3d:	83 c4 10             	add    $0x10,%esp
80104c40:	89 c6                	mov    %eax,%esi
80104c42:	85 c0                	test   %eax,%eax
80104c44:	74 4a                	je     80104c90 <create+0x90>
    iunlockput(dp);
80104c46:	83 ec 0c             	sub    $0xc,%esp
80104c49:	53                   	push   %ebx
80104c4a:	e8 41 ce ff ff       	call   80101a90 <iunlockput>
    ilock(ip);
80104c4f:	89 34 24             	mov    %esi,(%esp)
80104c52:	e8 a9 cb ff ff       	call   80101800 <ilock>
    if(type == T_FILE && ip->type == T_FILE)
80104c57:	83 c4 10             	add    $0x10,%esp
80104c5a:	66 83 7d d4 02       	cmpw   $0x2,-0x2c(%ebp)
80104c5f:	75 17                	jne    80104c78 <create+0x78>
80104c61:	66 83 7e 50 02       	cmpw   $0x2,0x50(%esi)
80104c66:	75 10                	jne    80104c78 <create+0x78>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
80104c68:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104c6b:	89 f0                	mov    %esi,%eax
80104c6d:	5b                   	pop    %ebx
80104c6e:	5e                   	pop    %esi
80104c6f:	5f                   	pop    %edi
80104c70:	5d                   	pop    %ebp
80104c71:	c3                   	ret
80104c72:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    iunlockput(ip);
80104c78:	83 ec 0c             	sub    $0xc,%esp
80104c7b:	56                   	push   %esi
80104c7c:	e8 0f ce ff ff       	call   80101a90 <iunlockput>
    return 0;
80104c81:	83 c4 10             	add    $0x10,%esp
}
80104c84:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return 0;
80104c87:	31 f6                	xor    %esi,%esi
}
80104c89:	5b                   	pop    %ebx
80104c8a:	89 f0                	mov    %esi,%eax
80104c8c:	5e                   	pop    %esi
80104c8d:	5f                   	pop    %edi
80104c8e:	5d                   	pop    %ebp
80104c8f:	c3                   	ret
  if((ip = ialloc(dp->dev, type)) == 0)
80104c90:	0f bf 45 d4          	movswl -0x2c(%ebp),%eax
80104c94:	83 ec 08             	sub    $0x8,%esp
80104c97:	50                   	push   %eax
80104c98:	ff 33                	push   (%ebx)
80104c9a:	e8 f1 c9 ff ff       	call   80101690 <ialloc>
80104c9f:	83 c4 10             	add    $0x10,%esp
80104ca2:	89 c6                	mov    %eax,%esi
80104ca4:	85 c0                	test   %eax,%eax
80104ca6:	0f 84 bc 00 00 00    	je     80104d68 <create+0x168>
  ilock(ip);
80104cac:	83 ec 0c             	sub    $0xc,%esp
80104caf:	50                   	push   %eax
80104cb0:	e8 4b cb ff ff       	call   80101800 <ilock>
  ip->major = major;
80104cb5:	0f b7 45 d0          	movzwl -0x30(%ebp),%eax
80104cb9:	66 89 46 52          	mov    %ax,0x52(%esi)
  ip->minor = minor;
80104cbd:	0f b7 45 cc          	movzwl -0x34(%ebp),%eax
80104cc1:	66 89 46 54          	mov    %ax,0x54(%esi)
  ip->nlink = 1;
80104cc5:	b8 01 00 00 00       	mov    $0x1,%eax
80104cca:	66 89 46 56          	mov    %ax,0x56(%esi)
  iupdate(ip);
80104cce:	89 34 24             	mov    %esi,(%esp)
80104cd1:	e8 7a ca ff ff       	call   80101750 <iupdate>
  if(type == T_DIR){  // Create . and .. entries.
80104cd6:	83 c4 10             	add    $0x10,%esp
80104cd9:	66 83 7d d4 01       	cmpw   $0x1,-0x2c(%ebp)
80104cde:	74 30                	je     80104d10 <create+0x110>
  if(dirlink(dp, name, ip->inum) < 0)
80104ce0:	83 ec 04             	sub    $0x4,%esp
80104ce3:	ff 76 04             	push   0x4(%esi)
80104ce6:	57                   	push   %edi
80104ce7:	53                   	push   %ebx
80104ce8:	e8 33 d3 ff ff       	call   80102020 <dirlink>
80104ced:	83 c4 10             	add    $0x10,%esp
80104cf0:	85 c0                	test   %eax,%eax
80104cf2:	78 67                	js     80104d5b <create+0x15b>
  iunlockput(dp);
80104cf4:	83 ec 0c             	sub    $0xc,%esp
80104cf7:	53                   	push   %ebx
80104cf8:	e8 93 cd ff ff       	call   80101a90 <iunlockput>
  return ip;
80104cfd:	83 c4 10             	add    $0x10,%esp
}
80104d00:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104d03:	89 f0                	mov    %esi,%eax
80104d05:	5b                   	pop    %ebx
80104d06:	5e                   	pop    %esi
80104d07:	5f                   	pop    %edi
80104d08:	5d                   	pop    %ebp
80104d09:	c3                   	ret
80104d0a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    iupdate(dp);
80104d10:	83 ec 0c             	sub    $0xc,%esp
    dp->nlink++;  // for ".."
80104d13:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
    iupdate(dp);
80104d18:	53                   	push   %ebx
80104d19:	e8 32 ca ff ff       	call   80101750 <iupdate>
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
80104d1e:	83 c4 0c             	add    $0xc,%esp
80104d21:	ff 76 04             	push   0x4(%esi)
80104d24:	68 09 86 10 80       	push   $0x80108609
80104d29:	56                   	push   %esi
80104d2a:	e8 f1 d2 ff ff       	call   80102020 <dirlink>
80104d2f:	83 c4 10             	add    $0x10,%esp
80104d32:	85 c0                	test   %eax,%eax
80104d34:	78 18                	js     80104d4e <create+0x14e>
80104d36:	83 ec 04             	sub    $0x4,%esp
80104d39:	ff 73 04             	push   0x4(%ebx)
80104d3c:	68 08 86 10 80       	push   $0x80108608
80104d41:	56                   	push   %esi
80104d42:	e8 d9 d2 ff ff       	call   80102020 <dirlink>
80104d47:	83 c4 10             	add    $0x10,%esp
80104d4a:	85 c0                	test   %eax,%eax
80104d4c:	79 92                	jns    80104ce0 <create+0xe0>
      panic("create dots");
80104d4e:	83 ec 0c             	sub    $0xc,%esp
80104d51:	68 fc 85 10 80       	push   $0x801085fc
80104d56:	e8 25 b6 ff ff       	call   80100380 <panic>
    panic("create: dirlink");
80104d5b:	83 ec 0c             	sub    $0xc,%esp
80104d5e:	68 0b 86 10 80       	push   $0x8010860b
80104d63:	e8 18 b6 ff ff       	call   80100380 <panic>
    panic("create: ialloc");
80104d68:	83 ec 0c             	sub    $0xc,%esp
80104d6b:	68 ed 85 10 80       	push   $0x801085ed
80104d70:	e8 0b b6 ff ff       	call   80100380 <panic>
80104d75:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104d7c:	00 
80104d7d:	8d 76 00             	lea    0x0(%esi),%esi

80104d80 <sys_dup>:
{
80104d80:	55                   	push   %ebp
80104d81:	89 e5                	mov    %esp,%ebp
80104d83:	56                   	push   %esi
80104d84:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
80104d85:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80104d88:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
80104d8b:	50                   	push   %eax
80104d8c:	6a 00                	push   $0x0
80104d8e:	e8 bd fc ff ff       	call   80104a50 <argint>
80104d93:	83 c4 10             	add    $0x10,%esp
80104d96:	85 c0                	test   %eax,%eax
80104d98:	78 36                	js     80104dd0 <sys_dup+0x50>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
80104d9a:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80104d9e:	77 30                	ja     80104dd0 <sys_dup+0x50>
80104da0:	e8 2b ec ff ff       	call   801039d0 <myproc>
80104da5:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104da8:	8b 74 90 28          	mov    0x28(%eax,%edx,4),%esi
80104dac:	85 f6                	test   %esi,%esi
80104dae:	74 20                	je     80104dd0 <sys_dup+0x50>
  struct proc *curproc = myproc();
80104db0:	e8 1b ec ff ff       	call   801039d0 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
80104db5:	31 db                	xor    %ebx,%ebx
80104db7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104dbe:	00 
80104dbf:	90                   	nop
    if(curproc->ofile[fd] == 0){
80104dc0:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80104dc4:	85 d2                	test   %edx,%edx
80104dc6:	74 18                	je     80104de0 <sys_dup+0x60>
  for(fd = 0; fd < NOFILE; fd++){
80104dc8:	83 c3 01             	add    $0x1,%ebx
80104dcb:	83 fb 10             	cmp    $0x10,%ebx
80104dce:	75 f0                	jne    80104dc0 <sys_dup+0x40>
}
80104dd0:	8d 65 f8             	lea    -0x8(%ebp),%esp
    return -1;
80104dd3:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
}
80104dd8:	89 d8                	mov    %ebx,%eax
80104dda:	5b                   	pop    %ebx
80104ddb:	5e                   	pop    %esi
80104ddc:	5d                   	pop    %ebp
80104ddd:	c3                   	ret
80104dde:	66 90                	xchg   %ax,%ax
  filedup(f);
80104de0:	83 ec 0c             	sub    $0xc,%esp
      curproc->ofile[fd] = f;
80104de3:	89 74 98 28          	mov    %esi,0x28(%eax,%ebx,4)
  filedup(f);
80104de7:	56                   	push   %esi
80104de8:	e8 33 c1 ff ff       	call   80100f20 <filedup>
  return fd;
80104ded:	83 c4 10             	add    $0x10,%esp
}
80104df0:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104df3:	89 d8                	mov    %ebx,%eax
80104df5:	5b                   	pop    %ebx
80104df6:	5e                   	pop    %esi
80104df7:	5d                   	pop    %ebp
80104df8:	c3                   	ret
80104df9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104e00 <sys_read>:
{
80104e00:	55                   	push   %ebp
80104e01:	89 e5                	mov    %esp,%ebp
80104e03:	56                   	push   %esi
80104e04:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
80104e05:	8d 5d f4             	lea    -0xc(%ebp),%ebx
{
80104e08:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
80104e0b:	53                   	push   %ebx
80104e0c:	6a 00                	push   $0x0
80104e0e:	e8 3d fc ff ff       	call   80104a50 <argint>
80104e13:	83 c4 10             	add    $0x10,%esp
80104e16:	85 c0                	test   %eax,%eax
80104e18:	78 5e                	js     80104e78 <sys_read+0x78>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
80104e1a:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80104e1e:	77 58                	ja     80104e78 <sys_read+0x78>
80104e20:	e8 ab eb ff ff       	call   801039d0 <myproc>
80104e25:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104e28:	8b 74 90 28          	mov    0x28(%eax,%edx,4),%esi
80104e2c:	85 f6                	test   %esi,%esi
80104e2e:	74 48                	je     80104e78 <sys_read+0x78>
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104e30:	83 ec 08             	sub    $0x8,%esp
80104e33:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104e36:	50                   	push   %eax
80104e37:	6a 02                	push   $0x2
80104e39:	e8 12 fc ff ff       	call   80104a50 <argint>
80104e3e:	83 c4 10             	add    $0x10,%esp
80104e41:	85 c0                	test   %eax,%eax
80104e43:	78 33                	js     80104e78 <sys_read+0x78>
80104e45:	83 ec 04             	sub    $0x4,%esp
80104e48:	ff 75 f0             	push   -0x10(%ebp)
80104e4b:	53                   	push   %ebx
80104e4c:	6a 01                	push   $0x1
80104e4e:	e8 4d fc ff ff       	call   80104aa0 <argptr>
80104e53:	83 c4 10             	add    $0x10,%esp
80104e56:	85 c0                	test   %eax,%eax
80104e58:	78 1e                	js     80104e78 <sys_read+0x78>
  return fileread(f, p, n);
80104e5a:	83 ec 04             	sub    $0x4,%esp
80104e5d:	ff 75 f0             	push   -0x10(%ebp)
80104e60:	ff 75 f4             	push   -0xc(%ebp)
80104e63:	56                   	push   %esi
80104e64:	e8 37 c2 ff ff       	call   801010a0 <fileread>
80104e69:	83 c4 10             	add    $0x10,%esp
}
80104e6c:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104e6f:	5b                   	pop    %ebx
80104e70:	5e                   	pop    %esi
80104e71:	5d                   	pop    %ebp
80104e72:	c3                   	ret
80104e73:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    return -1;
80104e78:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104e7d:	eb ed                	jmp    80104e6c <sys_read+0x6c>
80104e7f:	90                   	nop

80104e80 <sys_write>:
{
80104e80:	55                   	push   %ebp
80104e81:	89 e5                	mov    %esp,%ebp
80104e83:	56                   	push   %esi
80104e84:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
80104e85:	8d 5d f4             	lea    -0xc(%ebp),%ebx
{
80104e88:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
80104e8b:	53                   	push   %ebx
80104e8c:	6a 00                	push   $0x0
80104e8e:	e8 bd fb ff ff       	call   80104a50 <argint>
80104e93:	83 c4 10             	add    $0x10,%esp
80104e96:	85 c0                	test   %eax,%eax
80104e98:	78 5e                	js     80104ef8 <sys_write+0x78>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
80104e9a:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80104e9e:	77 58                	ja     80104ef8 <sys_write+0x78>
80104ea0:	e8 2b eb ff ff       	call   801039d0 <myproc>
80104ea5:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104ea8:	8b 74 90 28          	mov    0x28(%eax,%edx,4),%esi
80104eac:	85 f6                	test   %esi,%esi
80104eae:	74 48                	je     80104ef8 <sys_write+0x78>
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104eb0:	83 ec 08             	sub    $0x8,%esp
80104eb3:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104eb6:	50                   	push   %eax
80104eb7:	6a 02                	push   $0x2
80104eb9:	e8 92 fb ff ff       	call   80104a50 <argint>
80104ebe:	83 c4 10             	add    $0x10,%esp
80104ec1:	85 c0                	test   %eax,%eax
80104ec3:	78 33                	js     80104ef8 <sys_write+0x78>
80104ec5:	83 ec 04             	sub    $0x4,%esp
80104ec8:	ff 75 f0             	push   -0x10(%ebp)
80104ecb:	53                   	push   %ebx
80104ecc:	6a 01                	push   $0x1
80104ece:	e8 cd fb ff ff       	call   80104aa0 <argptr>
80104ed3:	83 c4 10             	add    $0x10,%esp
80104ed6:	85 c0                	test   %eax,%eax
80104ed8:	78 1e                	js     80104ef8 <sys_write+0x78>
  return filewrite(f, p, n);
80104eda:	83 ec 04             	sub    $0x4,%esp
80104edd:	ff 75 f0             	push   -0x10(%ebp)
80104ee0:	ff 75 f4             	push   -0xc(%ebp)
80104ee3:	56                   	push   %esi
80104ee4:	e8 47 c2 ff ff       	call   80101130 <filewrite>
80104ee9:	83 c4 10             	add    $0x10,%esp
}
80104eec:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104eef:	5b                   	pop    %ebx
80104ef0:	5e                   	pop    %esi
80104ef1:	5d                   	pop    %ebp
80104ef2:	c3                   	ret
80104ef3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    return -1;
80104ef8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104efd:	eb ed                	jmp    80104eec <sys_write+0x6c>
80104eff:	90                   	nop

80104f00 <sys_close>:
{
80104f00:	55                   	push   %ebp
80104f01:	89 e5                	mov    %esp,%ebp
80104f03:	56                   	push   %esi
80104f04:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
80104f05:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80104f08:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
80104f0b:	50                   	push   %eax
80104f0c:	6a 00                	push   $0x0
80104f0e:	e8 3d fb ff ff       	call   80104a50 <argint>
80104f13:	83 c4 10             	add    $0x10,%esp
80104f16:	85 c0                	test   %eax,%eax
80104f18:	78 3e                	js     80104f58 <sys_close+0x58>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
80104f1a:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80104f1e:	77 38                	ja     80104f58 <sys_close+0x58>
80104f20:	e8 ab ea ff ff       	call   801039d0 <myproc>
80104f25:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104f28:	8d 5a 08             	lea    0x8(%edx),%ebx
80104f2b:	8b 74 98 08          	mov    0x8(%eax,%ebx,4),%esi
80104f2f:	85 f6                	test   %esi,%esi
80104f31:	74 25                	je     80104f58 <sys_close+0x58>
  myproc()->ofile[fd] = 0;
80104f33:	e8 98 ea ff ff       	call   801039d0 <myproc>
  fileclose(f);
80104f38:	83 ec 0c             	sub    $0xc,%esp
  myproc()->ofile[fd] = 0;
80104f3b:	c7 44 98 08 00 00 00 	movl   $0x0,0x8(%eax,%ebx,4)
80104f42:	00 
  fileclose(f);
80104f43:	56                   	push   %esi
80104f44:	e8 27 c0 ff ff       	call   80100f70 <fileclose>
  return 0;
80104f49:	83 c4 10             	add    $0x10,%esp
80104f4c:	31 c0                	xor    %eax,%eax
}
80104f4e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104f51:	5b                   	pop    %ebx
80104f52:	5e                   	pop    %esi
80104f53:	5d                   	pop    %ebp
80104f54:	c3                   	ret
80104f55:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
80104f58:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104f5d:	eb ef                	jmp    80104f4e <sys_close+0x4e>
80104f5f:	90                   	nop

80104f60 <sys_fstat>:
{
80104f60:	55                   	push   %ebp
80104f61:	89 e5                	mov    %esp,%ebp
80104f63:	56                   	push   %esi
80104f64:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
80104f65:	8d 5d f4             	lea    -0xc(%ebp),%ebx
{
80104f68:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
80104f6b:	53                   	push   %ebx
80104f6c:	6a 00                	push   $0x0
80104f6e:	e8 dd fa ff ff       	call   80104a50 <argint>
80104f73:	83 c4 10             	add    $0x10,%esp
80104f76:	85 c0                	test   %eax,%eax
80104f78:	78 46                	js     80104fc0 <sys_fstat+0x60>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
80104f7a:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80104f7e:	77 40                	ja     80104fc0 <sys_fstat+0x60>
80104f80:	e8 4b ea ff ff       	call   801039d0 <myproc>
80104f85:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104f88:	8b 74 90 28          	mov    0x28(%eax,%edx,4),%esi
80104f8c:	85 f6                	test   %esi,%esi
80104f8e:	74 30                	je     80104fc0 <sys_fstat+0x60>
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80104f90:	83 ec 04             	sub    $0x4,%esp
80104f93:	6a 14                	push   $0x14
80104f95:	53                   	push   %ebx
80104f96:	6a 01                	push   $0x1
80104f98:	e8 03 fb ff ff       	call   80104aa0 <argptr>
80104f9d:	83 c4 10             	add    $0x10,%esp
80104fa0:	85 c0                	test   %eax,%eax
80104fa2:	78 1c                	js     80104fc0 <sys_fstat+0x60>
  return filestat(f, st);
80104fa4:	83 ec 08             	sub    $0x8,%esp
80104fa7:	ff 75 f4             	push   -0xc(%ebp)
80104faa:	56                   	push   %esi
80104fab:	e8 a0 c0 ff ff       	call   80101050 <filestat>
80104fb0:	83 c4 10             	add    $0x10,%esp
}
80104fb3:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104fb6:	5b                   	pop    %ebx
80104fb7:	5e                   	pop    %esi
80104fb8:	5d                   	pop    %ebp
80104fb9:	c3                   	ret
80104fba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
80104fc0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104fc5:	eb ec                	jmp    80104fb3 <sys_fstat+0x53>
80104fc7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104fce:	00 
80104fcf:	90                   	nop

80104fd0 <sys_link>:
{
80104fd0:	55                   	push   %ebp
80104fd1:	89 e5                	mov    %esp,%ebp
80104fd3:	57                   	push   %edi
80104fd4:	56                   	push   %esi
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80104fd5:	8d 45 d4             	lea    -0x2c(%ebp),%eax
{
80104fd8:	53                   	push   %ebx
80104fd9:	83 ec 34             	sub    $0x34,%esp
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80104fdc:	50                   	push   %eax
80104fdd:	6a 00                	push   $0x0
80104fdf:	e8 2c fb ff ff       	call   80104b10 <argstr>
80104fe4:	83 c4 10             	add    $0x10,%esp
80104fe7:	85 c0                	test   %eax,%eax
80104fe9:	0f 88 fb 00 00 00    	js     801050ea <sys_link+0x11a>
80104fef:	83 ec 08             	sub    $0x8,%esp
80104ff2:	8d 45 d0             	lea    -0x30(%ebp),%eax
80104ff5:	50                   	push   %eax
80104ff6:	6a 01                	push   $0x1
80104ff8:	e8 13 fb ff ff       	call   80104b10 <argstr>
80104ffd:	83 c4 10             	add    $0x10,%esp
80105000:	85 c0                	test   %eax,%eax
80105002:	0f 88 e2 00 00 00    	js     801050ea <sys_link+0x11a>
  begin_op();
80105008:	e8 93 dd ff ff       	call   80102da0 <begin_op>
  if((ip = namei(old)) == 0){
8010500d:	83 ec 0c             	sub    $0xc,%esp
80105010:	ff 75 d4             	push   -0x2c(%ebp)
80105013:	e8 c8 d0 ff ff       	call   801020e0 <namei>
80105018:	83 c4 10             	add    $0x10,%esp
8010501b:	89 c3                	mov    %eax,%ebx
8010501d:	85 c0                	test   %eax,%eax
8010501f:	0f 84 df 00 00 00    	je     80105104 <sys_link+0x134>
  ilock(ip);
80105025:	83 ec 0c             	sub    $0xc,%esp
80105028:	50                   	push   %eax
80105029:	e8 d2 c7 ff ff       	call   80101800 <ilock>
  if(ip->type == T_DIR){
8010502e:	83 c4 10             	add    $0x10,%esp
80105031:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105036:	0f 84 b5 00 00 00    	je     801050f1 <sys_link+0x121>
  iupdate(ip);
8010503c:	83 ec 0c             	sub    $0xc,%esp
  ip->nlink++;
8010503f:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
  if((dp = nameiparent(new, name)) == 0)
80105044:	8d 7d da             	lea    -0x26(%ebp),%edi
  iupdate(ip);
80105047:	53                   	push   %ebx
80105048:	e8 03 c7 ff ff       	call   80101750 <iupdate>
  iunlock(ip);
8010504d:	89 1c 24             	mov    %ebx,(%esp)
80105050:	e8 8b c8 ff ff       	call   801018e0 <iunlock>
  if((dp = nameiparent(new, name)) == 0)
80105055:	58                   	pop    %eax
80105056:	5a                   	pop    %edx
80105057:	57                   	push   %edi
80105058:	ff 75 d0             	push   -0x30(%ebp)
8010505b:	e8 a0 d0 ff ff       	call   80102100 <nameiparent>
80105060:	83 c4 10             	add    $0x10,%esp
80105063:	89 c6                	mov    %eax,%esi
80105065:	85 c0                	test   %eax,%eax
80105067:	74 5b                	je     801050c4 <sys_link+0xf4>
  ilock(dp);
80105069:	83 ec 0c             	sub    $0xc,%esp
8010506c:	50                   	push   %eax
8010506d:	e8 8e c7 ff ff       	call   80101800 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
80105072:	8b 03                	mov    (%ebx),%eax
80105074:	83 c4 10             	add    $0x10,%esp
80105077:	39 06                	cmp    %eax,(%esi)
80105079:	75 3d                	jne    801050b8 <sys_link+0xe8>
8010507b:	83 ec 04             	sub    $0x4,%esp
8010507e:	ff 73 04             	push   0x4(%ebx)
80105081:	57                   	push   %edi
80105082:	56                   	push   %esi
80105083:	e8 98 cf ff ff       	call   80102020 <dirlink>
80105088:	83 c4 10             	add    $0x10,%esp
8010508b:	85 c0                	test   %eax,%eax
8010508d:	78 29                	js     801050b8 <sys_link+0xe8>
  iunlockput(dp);
8010508f:	83 ec 0c             	sub    $0xc,%esp
80105092:	56                   	push   %esi
80105093:	e8 f8 c9 ff ff       	call   80101a90 <iunlockput>
  iput(ip);
80105098:	89 1c 24             	mov    %ebx,(%esp)
8010509b:	e8 90 c8 ff ff       	call   80101930 <iput>
  end_op();
801050a0:	e8 6b dd ff ff       	call   80102e10 <end_op>
  return 0;
801050a5:	83 c4 10             	add    $0x10,%esp
801050a8:	31 c0                	xor    %eax,%eax
}
801050aa:	8d 65 f4             	lea    -0xc(%ebp),%esp
801050ad:	5b                   	pop    %ebx
801050ae:	5e                   	pop    %esi
801050af:	5f                   	pop    %edi
801050b0:	5d                   	pop    %ebp
801050b1:	c3                   	ret
801050b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    iunlockput(dp);
801050b8:	83 ec 0c             	sub    $0xc,%esp
801050bb:	56                   	push   %esi
801050bc:	e8 cf c9 ff ff       	call   80101a90 <iunlockput>
    goto bad;
801050c1:	83 c4 10             	add    $0x10,%esp
  ilock(ip);
801050c4:	83 ec 0c             	sub    $0xc,%esp
801050c7:	53                   	push   %ebx
801050c8:	e8 33 c7 ff ff       	call   80101800 <ilock>
  ip->nlink--;
801050cd:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
801050d2:	89 1c 24             	mov    %ebx,(%esp)
801050d5:	e8 76 c6 ff ff       	call   80101750 <iupdate>
  iunlockput(ip);
801050da:	89 1c 24             	mov    %ebx,(%esp)
801050dd:	e8 ae c9 ff ff       	call   80101a90 <iunlockput>
  end_op();
801050e2:	e8 29 dd ff ff       	call   80102e10 <end_op>
  return -1;
801050e7:	83 c4 10             	add    $0x10,%esp
    return -1;
801050ea:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801050ef:	eb b9                	jmp    801050aa <sys_link+0xda>
    iunlockput(ip);
801050f1:	83 ec 0c             	sub    $0xc,%esp
801050f4:	53                   	push   %ebx
801050f5:	e8 96 c9 ff ff       	call   80101a90 <iunlockput>
    end_op();
801050fa:	e8 11 dd ff ff       	call   80102e10 <end_op>
    return -1;
801050ff:	83 c4 10             	add    $0x10,%esp
80105102:	eb e6                	jmp    801050ea <sys_link+0x11a>
    end_op();
80105104:	e8 07 dd ff ff       	call   80102e10 <end_op>
    return -1;
80105109:	eb df                	jmp    801050ea <sys_link+0x11a>
8010510b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80105110 <sys_unlink>:
{
80105110:	55                   	push   %ebp
80105111:	89 e5                	mov    %esp,%ebp
80105113:	57                   	push   %edi
80105114:	56                   	push   %esi
  if(argstr(0, &path) < 0)
80105115:	8d 45 c0             	lea    -0x40(%ebp),%eax
{
80105118:	53                   	push   %ebx
80105119:	83 ec 54             	sub    $0x54,%esp
  if(argstr(0, &path) < 0)
8010511c:	50                   	push   %eax
8010511d:	6a 00                	push   $0x0
8010511f:	e8 ec f9 ff ff       	call   80104b10 <argstr>
80105124:	83 c4 10             	add    $0x10,%esp
80105127:	85 c0                	test   %eax,%eax
80105129:	0f 88 54 01 00 00    	js     80105283 <sys_unlink+0x173>
  begin_op();
8010512f:	e8 6c dc ff ff       	call   80102da0 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
80105134:	8d 5d ca             	lea    -0x36(%ebp),%ebx
80105137:	83 ec 08             	sub    $0x8,%esp
8010513a:	53                   	push   %ebx
8010513b:	ff 75 c0             	push   -0x40(%ebp)
8010513e:	e8 bd cf ff ff       	call   80102100 <nameiparent>
80105143:	83 c4 10             	add    $0x10,%esp
80105146:	89 45 b4             	mov    %eax,-0x4c(%ebp)
80105149:	85 c0                	test   %eax,%eax
8010514b:	0f 84 58 01 00 00    	je     801052a9 <sys_unlink+0x199>
  ilock(dp);
80105151:	8b 7d b4             	mov    -0x4c(%ebp),%edi
80105154:	83 ec 0c             	sub    $0xc,%esp
80105157:	57                   	push   %edi
80105158:	e8 a3 c6 ff ff       	call   80101800 <ilock>
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
8010515d:	58                   	pop    %eax
8010515e:	5a                   	pop    %edx
8010515f:	68 09 86 10 80       	push   $0x80108609
80105164:	53                   	push   %ebx
80105165:	e8 c6 cb ff ff       	call   80101d30 <namecmp>
8010516a:	83 c4 10             	add    $0x10,%esp
8010516d:	85 c0                	test   %eax,%eax
8010516f:	0f 84 fb 00 00 00    	je     80105270 <sys_unlink+0x160>
80105175:	83 ec 08             	sub    $0x8,%esp
80105178:	68 08 86 10 80       	push   $0x80108608
8010517d:	53                   	push   %ebx
8010517e:	e8 ad cb ff ff       	call   80101d30 <namecmp>
80105183:	83 c4 10             	add    $0x10,%esp
80105186:	85 c0                	test   %eax,%eax
80105188:	0f 84 e2 00 00 00    	je     80105270 <sys_unlink+0x160>
  if((ip = dirlookup(dp, name, &off)) == 0)
8010518e:	83 ec 04             	sub    $0x4,%esp
80105191:	8d 45 c4             	lea    -0x3c(%ebp),%eax
80105194:	50                   	push   %eax
80105195:	53                   	push   %ebx
80105196:	57                   	push   %edi
80105197:	e8 b4 cb ff ff       	call   80101d50 <dirlookup>
8010519c:	83 c4 10             	add    $0x10,%esp
8010519f:	89 c3                	mov    %eax,%ebx
801051a1:	85 c0                	test   %eax,%eax
801051a3:	0f 84 c7 00 00 00    	je     80105270 <sys_unlink+0x160>
  ilock(ip);
801051a9:	83 ec 0c             	sub    $0xc,%esp
801051ac:	50                   	push   %eax
801051ad:	e8 4e c6 ff ff       	call   80101800 <ilock>
  if(ip->nlink < 1)
801051b2:	83 c4 10             	add    $0x10,%esp
801051b5:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
801051ba:	0f 8e 0a 01 00 00    	jle    801052ca <sys_unlink+0x1ba>
  if(ip->type == T_DIR && !isdirempty(ip)){
801051c0:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
801051c5:	8d 7d d8             	lea    -0x28(%ebp),%edi
801051c8:	74 66                	je     80105230 <sys_unlink+0x120>
  memset(&de, 0, sizeof(de));
801051ca:	83 ec 04             	sub    $0x4,%esp
801051cd:	6a 10                	push   $0x10
801051cf:	6a 00                	push   $0x0
801051d1:	57                   	push   %edi
801051d2:	e8 c9 f5 ff ff       	call   801047a0 <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
801051d7:	6a 10                	push   $0x10
801051d9:	ff 75 c4             	push   -0x3c(%ebp)
801051dc:	57                   	push   %edi
801051dd:	ff 75 b4             	push   -0x4c(%ebp)
801051e0:	e8 2b ca ff ff       	call   80101c10 <writei>
801051e5:	83 c4 20             	add    $0x20,%esp
801051e8:	83 f8 10             	cmp    $0x10,%eax
801051eb:	0f 85 cc 00 00 00    	jne    801052bd <sys_unlink+0x1ad>
  if(ip->type == T_DIR){
801051f1:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
801051f6:	0f 84 94 00 00 00    	je     80105290 <sys_unlink+0x180>
  iunlockput(dp);
801051fc:	83 ec 0c             	sub    $0xc,%esp
801051ff:	ff 75 b4             	push   -0x4c(%ebp)
80105202:	e8 89 c8 ff ff       	call   80101a90 <iunlockput>
  ip->nlink--;
80105207:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
8010520c:	89 1c 24             	mov    %ebx,(%esp)
8010520f:	e8 3c c5 ff ff       	call   80101750 <iupdate>
  iunlockput(ip);
80105214:	89 1c 24             	mov    %ebx,(%esp)
80105217:	e8 74 c8 ff ff       	call   80101a90 <iunlockput>
  end_op();
8010521c:	e8 ef db ff ff       	call   80102e10 <end_op>
  return 0;
80105221:	83 c4 10             	add    $0x10,%esp
80105224:	31 c0                	xor    %eax,%eax
}
80105226:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105229:	5b                   	pop    %ebx
8010522a:	5e                   	pop    %esi
8010522b:	5f                   	pop    %edi
8010522c:	5d                   	pop    %ebp
8010522d:	c3                   	ret
8010522e:	66 90                	xchg   %ax,%ax
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
80105230:	83 7b 58 20          	cmpl   $0x20,0x58(%ebx)
80105234:	76 94                	jbe    801051ca <sys_unlink+0xba>
80105236:	be 20 00 00 00       	mov    $0x20,%esi
8010523b:	eb 0b                	jmp    80105248 <sys_unlink+0x138>
8010523d:	8d 76 00             	lea    0x0(%esi),%esi
80105240:	83 c6 10             	add    $0x10,%esi
80105243:	3b 73 58             	cmp    0x58(%ebx),%esi
80105246:	73 82                	jae    801051ca <sys_unlink+0xba>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80105248:	6a 10                	push   $0x10
8010524a:	56                   	push   %esi
8010524b:	57                   	push   %edi
8010524c:	53                   	push   %ebx
8010524d:	e8 be c8 ff ff       	call   80101b10 <readi>
80105252:	83 c4 10             	add    $0x10,%esp
80105255:	83 f8 10             	cmp    $0x10,%eax
80105258:	75 56                	jne    801052b0 <sys_unlink+0x1a0>
    if(de.inum != 0)
8010525a:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
8010525f:	74 df                	je     80105240 <sys_unlink+0x130>
    iunlockput(ip);
80105261:	83 ec 0c             	sub    $0xc,%esp
80105264:	53                   	push   %ebx
80105265:	e8 26 c8 ff ff       	call   80101a90 <iunlockput>
    goto bad;
8010526a:	83 c4 10             	add    $0x10,%esp
8010526d:	8d 76 00             	lea    0x0(%esi),%esi
  iunlockput(dp);
80105270:	83 ec 0c             	sub    $0xc,%esp
80105273:	ff 75 b4             	push   -0x4c(%ebp)
80105276:	e8 15 c8 ff ff       	call   80101a90 <iunlockput>
  end_op();
8010527b:	e8 90 db ff ff       	call   80102e10 <end_op>
  return -1;
80105280:	83 c4 10             	add    $0x10,%esp
    return -1;
80105283:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105288:	eb 9c                	jmp    80105226 <sys_unlink+0x116>
8010528a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    dp->nlink--;
80105290:	8b 45 b4             	mov    -0x4c(%ebp),%eax
    iupdate(dp);
80105293:	83 ec 0c             	sub    $0xc,%esp
    dp->nlink--;
80105296:	66 83 68 56 01       	subw   $0x1,0x56(%eax)
    iupdate(dp);
8010529b:	50                   	push   %eax
8010529c:	e8 af c4 ff ff       	call   80101750 <iupdate>
801052a1:	83 c4 10             	add    $0x10,%esp
801052a4:	e9 53 ff ff ff       	jmp    801051fc <sys_unlink+0xec>
    end_op();
801052a9:	e8 62 db ff ff       	call   80102e10 <end_op>
    return -1;
801052ae:	eb d3                	jmp    80105283 <sys_unlink+0x173>
      panic("isdirempty: readi");
801052b0:	83 ec 0c             	sub    $0xc,%esp
801052b3:	68 2d 86 10 80       	push   $0x8010862d
801052b8:	e8 c3 b0 ff ff       	call   80100380 <panic>
    panic("unlink: writei");
801052bd:	83 ec 0c             	sub    $0xc,%esp
801052c0:	68 3f 86 10 80       	push   $0x8010863f
801052c5:	e8 b6 b0 ff ff       	call   80100380 <panic>
    panic("unlink: nlink < 1");
801052ca:	83 ec 0c             	sub    $0xc,%esp
801052cd:	68 1b 86 10 80       	push   $0x8010861b
801052d2:	e8 a9 b0 ff ff       	call   80100380 <panic>
801052d7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801052de:	00 
801052df:	90                   	nop

801052e0 <sys_open>:

int
sys_open(void)
{
801052e0:	55                   	push   %ebp
801052e1:	89 e5                	mov    %esp,%ebp
801052e3:	57                   	push   %edi
801052e4:	56                   	push   %esi
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
801052e5:	8d 45 e0             	lea    -0x20(%ebp),%eax
{
801052e8:	53                   	push   %ebx
801052e9:	83 ec 24             	sub    $0x24,%esp
  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
801052ec:	50                   	push   %eax
801052ed:	6a 00                	push   $0x0
801052ef:	e8 1c f8 ff ff       	call   80104b10 <argstr>
801052f4:	83 c4 10             	add    $0x10,%esp
801052f7:	85 c0                	test   %eax,%eax
801052f9:	0f 88 8e 00 00 00    	js     8010538d <sys_open+0xad>
801052ff:	83 ec 08             	sub    $0x8,%esp
80105302:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105305:	50                   	push   %eax
80105306:	6a 01                	push   $0x1
80105308:	e8 43 f7 ff ff       	call   80104a50 <argint>
8010530d:	83 c4 10             	add    $0x10,%esp
80105310:	85 c0                	test   %eax,%eax
80105312:	78 79                	js     8010538d <sys_open+0xad>
    return -1;

  begin_op();
80105314:	e8 87 da ff ff       	call   80102da0 <begin_op>

  if(omode & O_CREATE){
80105319:	f6 45 e5 02          	testb  $0x2,-0x1b(%ebp)
8010531d:	75 79                	jne    80105398 <sys_open+0xb8>
    if(ip == 0){
      end_op();
      return -1;
    }
  } else {
    if((ip = namei(path)) == 0){
8010531f:	83 ec 0c             	sub    $0xc,%esp
80105322:	ff 75 e0             	push   -0x20(%ebp)
80105325:	e8 b6 cd ff ff       	call   801020e0 <namei>
8010532a:	83 c4 10             	add    $0x10,%esp
8010532d:	89 c6                	mov    %eax,%esi
8010532f:	85 c0                	test   %eax,%eax
80105331:	0f 84 7e 00 00 00    	je     801053b5 <sys_open+0xd5>
      end_op();
      return -1;
    }
    ilock(ip);
80105337:	83 ec 0c             	sub    $0xc,%esp
8010533a:	50                   	push   %eax
8010533b:	e8 c0 c4 ff ff       	call   80101800 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
80105340:	83 c4 10             	add    $0x10,%esp
80105343:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80105348:	0f 84 ba 00 00 00    	je     80105408 <sys_open+0x128>
      end_op();
      return -1;
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
8010534e:	e8 5d bb ff ff       	call   80100eb0 <filealloc>
80105353:	89 c7                	mov    %eax,%edi
80105355:	85 c0                	test   %eax,%eax
80105357:	74 23                	je     8010537c <sys_open+0x9c>
  struct proc *curproc = myproc();
80105359:	e8 72 e6 ff ff       	call   801039d0 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
8010535e:	31 db                	xor    %ebx,%ebx
    if(curproc->ofile[fd] == 0){
80105360:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80105364:	85 d2                	test   %edx,%edx
80105366:	74 58                	je     801053c0 <sys_open+0xe0>
  for(fd = 0; fd < NOFILE; fd++){
80105368:	83 c3 01             	add    $0x1,%ebx
8010536b:	83 fb 10             	cmp    $0x10,%ebx
8010536e:	75 f0                	jne    80105360 <sys_open+0x80>
    if(f)
      fileclose(f);
80105370:	83 ec 0c             	sub    $0xc,%esp
80105373:	57                   	push   %edi
80105374:	e8 f7 bb ff ff       	call   80100f70 <fileclose>
80105379:	83 c4 10             	add    $0x10,%esp
    iunlockput(ip);
8010537c:	83 ec 0c             	sub    $0xc,%esp
8010537f:	56                   	push   %esi
80105380:	e8 0b c7 ff ff       	call   80101a90 <iunlockput>
    end_op();
80105385:	e8 86 da ff ff       	call   80102e10 <end_op>
    return -1;
8010538a:	83 c4 10             	add    $0x10,%esp
    return -1;
8010538d:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80105392:	eb 65                	jmp    801053f9 <sys_open+0x119>
80105394:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    ip = create(path, T_FILE, 0, 0);
80105398:	83 ec 0c             	sub    $0xc,%esp
8010539b:	31 c9                	xor    %ecx,%ecx
8010539d:	ba 02 00 00 00       	mov    $0x2,%edx
801053a2:	6a 00                	push   $0x0
801053a4:	8b 45 e0             	mov    -0x20(%ebp),%eax
801053a7:	e8 54 f8 ff ff       	call   80104c00 <create>
    if(ip == 0){
801053ac:	83 c4 10             	add    $0x10,%esp
    ip = create(path, T_FILE, 0, 0);
801053af:	89 c6                	mov    %eax,%esi
    if(ip == 0){
801053b1:	85 c0                	test   %eax,%eax
801053b3:	75 99                	jne    8010534e <sys_open+0x6e>
      end_op();
801053b5:	e8 56 da ff ff       	call   80102e10 <end_op>
      return -1;
801053ba:	eb d1                	jmp    8010538d <sys_open+0xad>
801053bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  }
  iunlock(ip);
801053c0:	83 ec 0c             	sub    $0xc,%esp
      curproc->ofile[fd] = f;
801053c3:	89 7c 98 28          	mov    %edi,0x28(%eax,%ebx,4)
  iunlock(ip);
801053c7:	56                   	push   %esi
801053c8:	e8 13 c5 ff ff       	call   801018e0 <iunlock>
  end_op();
801053cd:	e8 3e da ff ff       	call   80102e10 <end_op>

  f->type = FD_INODE;
801053d2:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
801053d8:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
801053db:	83 c4 10             	add    $0x10,%esp
  f->ip = ip;
801053de:	89 77 10             	mov    %esi,0x10(%edi)
  f->readable = !(omode & O_WRONLY);
801053e1:	89 d0                	mov    %edx,%eax
  f->off = 0;
801053e3:	c7 47 14 00 00 00 00 	movl   $0x0,0x14(%edi)
  f->readable = !(omode & O_WRONLY);
801053ea:	f7 d0                	not    %eax
801053ec:	83 e0 01             	and    $0x1,%eax
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
801053ef:	83 e2 03             	and    $0x3,%edx
  f->readable = !(omode & O_WRONLY);
801053f2:	88 47 08             	mov    %al,0x8(%edi)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
801053f5:	0f 95 47 09          	setne  0x9(%edi)
  return fd;
}
801053f9:	8d 65 f4             	lea    -0xc(%ebp),%esp
801053fc:	89 d8                	mov    %ebx,%eax
801053fe:	5b                   	pop    %ebx
801053ff:	5e                   	pop    %esi
80105400:	5f                   	pop    %edi
80105401:	5d                   	pop    %ebp
80105402:	c3                   	ret
80105403:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    if(ip->type == T_DIR && omode != O_RDONLY){
80105408:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
8010540b:	85 c9                	test   %ecx,%ecx
8010540d:	0f 84 3b ff ff ff    	je     8010534e <sys_open+0x6e>
80105413:	e9 64 ff ff ff       	jmp    8010537c <sys_open+0x9c>
80105418:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010541f:	00 

80105420 <sys_mkdir>:

int
sys_mkdir(void)
{
80105420:	55                   	push   %ebp
80105421:	89 e5                	mov    %esp,%ebp
80105423:	83 ec 18             	sub    $0x18,%esp
  char *path;
  struct inode *ip;

  begin_op();
80105426:	e8 75 d9 ff ff       	call   80102da0 <begin_op>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
8010542b:	83 ec 08             	sub    $0x8,%esp
8010542e:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105431:	50                   	push   %eax
80105432:	6a 00                	push   $0x0
80105434:	e8 d7 f6 ff ff       	call   80104b10 <argstr>
80105439:	83 c4 10             	add    $0x10,%esp
8010543c:	85 c0                	test   %eax,%eax
8010543e:	78 30                	js     80105470 <sys_mkdir+0x50>
80105440:	83 ec 0c             	sub    $0xc,%esp
80105443:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105446:	31 c9                	xor    %ecx,%ecx
80105448:	ba 01 00 00 00       	mov    $0x1,%edx
8010544d:	6a 00                	push   $0x0
8010544f:	e8 ac f7 ff ff       	call   80104c00 <create>
80105454:	83 c4 10             	add    $0x10,%esp
80105457:	85 c0                	test   %eax,%eax
80105459:	74 15                	je     80105470 <sys_mkdir+0x50>
    end_op();
    return -1;
  }
  iunlockput(ip);
8010545b:	83 ec 0c             	sub    $0xc,%esp
8010545e:	50                   	push   %eax
8010545f:	e8 2c c6 ff ff       	call   80101a90 <iunlockput>
  end_op();
80105464:	e8 a7 d9 ff ff       	call   80102e10 <end_op>
  return 0;
80105469:	83 c4 10             	add    $0x10,%esp
8010546c:	31 c0                	xor    %eax,%eax
}
8010546e:	c9                   	leave
8010546f:	c3                   	ret
    end_op();
80105470:	e8 9b d9 ff ff       	call   80102e10 <end_op>
    return -1;
80105475:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010547a:	c9                   	leave
8010547b:	c3                   	ret
8010547c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105480 <sys_mknod>:

int
sys_mknod(void)
{
80105480:	55                   	push   %ebp
80105481:	89 e5                	mov    %esp,%ebp
80105483:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
80105486:	e8 15 d9 ff ff       	call   80102da0 <begin_op>
  if((argstr(0, &path)) < 0 ||
8010548b:	83 ec 08             	sub    $0x8,%esp
8010548e:	8d 45 ec             	lea    -0x14(%ebp),%eax
80105491:	50                   	push   %eax
80105492:	6a 00                	push   $0x0
80105494:	e8 77 f6 ff ff       	call   80104b10 <argstr>
80105499:	83 c4 10             	add    $0x10,%esp
8010549c:	85 c0                	test   %eax,%eax
8010549e:	78 60                	js     80105500 <sys_mknod+0x80>
     argint(1, &major) < 0 ||
801054a0:	83 ec 08             	sub    $0x8,%esp
801054a3:	8d 45 f0             	lea    -0x10(%ebp),%eax
801054a6:	50                   	push   %eax
801054a7:	6a 01                	push   $0x1
801054a9:	e8 a2 f5 ff ff       	call   80104a50 <argint>
  if((argstr(0, &path)) < 0 ||
801054ae:	83 c4 10             	add    $0x10,%esp
801054b1:	85 c0                	test   %eax,%eax
801054b3:	78 4b                	js     80105500 <sys_mknod+0x80>
     argint(2, &minor) < 0 ||
801054b5:	83 ec 08             	sub    $0x8,%esp
801054b8:	8d 45 f4             	lea    -0xc(%ebp),%eax
801054bb:	50                   	push   %eax
801054bc:	6a 02                	push   $0x2
801054be:	e8 8d f5 ff ff       	call   80104a50 <argint>
     argint(1, &major) < 0 ||
801054c3:	83 c4 10             	add    $0x10,%esp
801054c6:	85 c0                	test   %eax,%eax
801054c8:	78 36                	js     80105500 <sys_mknod+0x80>
     (ip = create(path, T_DEV, major, minor)) == 0){
801054ca:	0f bf 45 f4          	movswl -0xc(%ebp),%eax
801054ce:	83 ec 0c             	sub    $0xc,%esp
801054d1:	0f bf 4d f0          	movswl -0x10(%ebp),%ecx
801054d5:	ba 03 00 00 00       	mov    $0x3,%edx
801054da:	50                   	push   %eax
801054db:	8b 45 ec             	mov    -0x14(%ebp),%eax
801054de:	e8 1d f7 ff ff       	call   80104c00 <create>
     argint(2, &minor) < 0 ||
801054e3:	83 c4 10             	add    $0x10,%esp
801054e6:	85 c0                	test   %eax,%eax
801054e8:	74 16                	je     80105500 <sys_mknod+0x80>
    end_op();
    return -1;
  }
  iunlockput(ip);
801054ea:	83 ec 0c             	sub    $0xc,%esp
801054ed:	50                   	push   %eax
801054ee:	e8 9d c5 ff ff       	call   80101a90 <iunlockput>
  end_op();
801054f3:	e8 18 d9 ff ff       	call   80102e10 <end_op>
  return 0;
801054f8:	83 c4 10             	add    $0x10,%esp
801054fb:	31 c0                	xor    %eax,%eax
}
801054fd:	c9                   	leave
801054fe:	c3                   	ret
801054ff:	90                   	nop
    end_op();
80105500:	e8 0b d9 ff ff       	call   80102e10 <end_op>
    return -1;
80105505:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010550a:	c9                   	leave
8010550b:	c3                   	ret
8010550c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105510 <sys_chdir>:

int
sys_chdir(void)
{
80105510:	55                   	push   %ebp
80105511:	89 e5                	mov    %esp,%ebp
80105513:	56                   	push   %esi
80105514:	53                   	push   %ebx
80105515:	83 ec 10             	sub    $0x10,%esp
  char *path;
  struct inode *ip;
  struct proc *curproc = myproc();
80105518:	e8 b3 e4 ff ff       	call   801039d0 <myproc>
8010551d:	89 c6                	mov    %eax,%esi
  
  begin_op();
8010551f:	e8 7c d8 ff ff       	call   80102da0 <begin_op>
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
80105524:	83 ec 08             	sub    $0x8,%esp
80105527:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010552a:	50                   	push   %eax
8010552b:	6a 00                	push   $0x0
8010552d:	e8 de f5 ff ff       	call   80104b10 <argstr>
80105532:	83 c4 10             	add    $0x10,%esp
80105535:	85 c0                	test   %eax,%eax
80105537:	78 77                	js     801055b0 <sys_chdir+0xa0>
80105539:	83 ec 0c             	sub    $0xc,%esp
8010553c:	ff 75 f4             	push   -0xc(%ebp)
8010553f:	e8 9c cb ff ff       	call   801020e0 <namei>
80105544:	83 c4 10             	add    $0x10,%esp
80105547:	89 c3                	mov    %eax,%ebx
80105549:	85 c0                	test   %eax,%eax
8010554b:	74 63                	je     801055b0 <sys_chdir+0xa0>
    end_op();
    return -1;
  }
  ilock(ip);
8010554d:	83 ec 0c             	sub    $0xc,%esp
80105550:	50                   	push   %eax
80105551:	e8 aa c2 ff ff       	call   80101800 <ilock>
  if(ip->type != T_DIR){
80105556:	83 c4 10             	add    $0x10,%esp
80105559:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
8010555e:	75 30                	jne    80105590 <sys_chdir+0x80>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
80105560:	83 ec 0c             	sub    $0xc,%esp
80105563:	53                   	push   %ebx
80105564:	e8 77 c3 ff ff       	call   801018e0 <iunlock>
  iput(curproc->cwd);
80105569:	58                   	pop    %eax
8010556a:	ff 76 68             	push   0x68(%esi)
8010556d:	e8 be c3 ff ff       	call   80101930 <iput>
  end_op();
80105572:	e8 99 d8 ff ff       	call   80102e10 <end_op>
  curproc->cwd = ip;
80105577:	89 5e 68             	mov    %ebx,0x68(%esi)
  return 0;
8010557a:	83 c4 10             	add    $0x10,%esp
8010557d:	31 c0                	xor    %eax,%eax
}
8010557f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105582:	5b                   	pop    %ebx
80105583:	5e                   	pop    %esi
80105584:	5d                   	pop    %ebp
80105585:	c3                   	ret
80105586:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010558d:	00 
8010558e:	66 90                	xchg   %ax,%ax
    iunlockput(ip);
80105590:	83 ec 0c             	sub    $0xc,%esp
80105593:	53                   	push   %ebx
80105594:	e8 f7 c4 ff ff       	call   80101a90 <iunlockput>
    end_op();
80105599:	e8 72 d8 ff ff       	call   80102e10 <end_op>
    return -1;
8010559e:	83 c4 10             	add    $0x10,%esp
    return -1;
801055a1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801055a6:	eb d7                	jmp    8010557f <sys_chdir+0x6f>
801055a8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801055af:	00 
    end_op();
801055b0:	e8 5b d8 ff ff       	call   80102e10 <end_op>
    return -1;
801055b5:	eb ea                	jmp    801055a1 <sys_chdir+0x91>
801055b7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801055be:	00 
801055bf:	90                   	nop

801055c0 <sys_exec>:

int
sys_exec(void)
{
801055c0:	55                   	push   %ebp
801055c1:	89 e5                	mov    %esp,%ebp
801055c3:	57                   	push   %edi
801055c4:	56                   	push   %esi
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
801055c5:	8d 85 5c ff ff ff    	lea    -0xa4(%ebp),%eax
{
801055cb:	53                   	push   %ebx
801055cc:	81 ec a4 00 00 00    	sub    $0xa4,%esp
  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
801055d2:	50                   	push   %eax
801055d3:	6a 00                	push   $0x0
801055d5:	e8 36 f5 ff ff       	call   80104b10 <argstr>
801055da:	83 c4 10             	add    $0x10,%esp
801055dd:	85 c0                	test   %eax,%eax
801055df:	0f 88 87 00 00 00    	js     8010566c <sys_exec+0xac>
801055e5:	83 ec 08             	sub    $0x8,%esp
801055e8:	8d 85 60 ff ff ff    	lea    -0xa0(%ebp),%eax
801055ee:	50                   	push   %eax
801055ef:	6a 01                	push   $0x1
801055f1:	e8 5a f4 ff ff       	call   80104a50 <argint>
801055f6:	83 c4 10             	add    $0x10,%esp
801055f9:	85 c0                	test   %eax,%eax
801055fb:	78 6f                	js     8010566c <sys_exec+0xac>
    return -1;
  }
  memset(argv, 0, sizeof(argv));
801055fd:	83 ec 04             	sub    $0x4,%esp
80105600:	8d b5 68 ff ff ff    	lea    -0x98(%ebp),%esi
  for(i=0;; i++){
80105606:	31 db                	xor    %ebx,%ebx
  memset(argv, 0, sizeof(argv));
80105608:	68 80 00 00 00       	push   $0x80
8010560d:	6a 00                	push   $0x0
8010560f:	56                   	push   %esi
80105610:	e8 8b f1 ff ff       	call   801047a0 <memset>
80105615:	83 c4 10             	add    $0x10,%esp
80105618:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010561f:	00 
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
80105620:	83 ec 08             	sub    $0x8,%esp
80105623:	8d 85 64 ff ff ff    	lea    -0x9c(%ebp),%eax
80105629:	8d 3c 9d 00 00 00 00 	lea    0x0(,%ebx,4),%edi
80105630:	50                   	push   %eax
80105631:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
80105637:	01 f8                	add    %edi,%eax
80105639:	50                   	push   %eax
8010563a:	e8 81 f3 ff ff       	call   801049c0 <fetchint>
8010563f:	83 c4 10             	add    $0x10,%esp
80105642:	85 c0                	test   %eax,%eax
80105644:	78 26                	js     8010566c <sys_exec+0xac>
      return -1;
    if(uarg == 0){
80105646:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
8010564c:	85 c0                	test   %eax,%eax
8010564e:	74 30                	je     80105680 <sys_exec+0xc0>
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
80105650:	83 ec 08             	sub    $0x8,%esp
80105653:	8d 14 3e             	lea    (%esi,%edi,1),%edx
80105656:	52                   	push   %edx
80105657:	50                   	push   %eax
80105658:	e8 a3 f3 ff ff       	call   80104a00 <fetchstr>
8010565d:	83 c4 10             	add    $0x10,%esp
80105660:	85 c0                	test   %eax,%eax
80105662:	78 08                	js     8010566c <sys_exec+0xac>
  for(i=0;; i++){
80105664:	83 c3 01             	add    $0x1,%ebx
    if(i >= NELEM(argv))
80105667:	83 fb 20             	cmp    $0x20,%ebx
8010566a:	75 b4                	jne    80105620 <sys_exec+0x60>
      return -1;
  }
  return exec(path, argv);
}
8010566c:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return -1;
8010566f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105674:	5b                   	pop    %ebx
80105675:	5e                   	pop    %esi
80105676:	5f                   	pop    %edi
80105677:	5d                   	pop    %ebp
80105678:	c3                   	ret
80105679:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      argv[i] = 0;
80105680:	c7 84 9d 68 ff ff ff 	movl   $0x0,-0x98(%ebp,%ebx,4)
80105687:	00 00 00 00 
  return exec(path, argv);
8010568b:	83 ec 08             	sub    $0x8,%esp
8010568e:	56                   	push   %esi
8010568f:	ff b5 5c ff ff ff    	push   -0xa4(%ebp)
80105695:	e8 16 b4 ff ff       	call   80100ab0 <exec>
8010569a:	83 c4 10             	add    $0x10,%esp
}
8010569d:	8d 65 f4             	lea    -0xc(%ebp),%esp
801056a0:	5b                   	pop    %ebx
801056a1:	5e                   	pop    %esi
801056a2:	5f                   	pop    %edi
801056a3:	5d                   	pop    %ebp
801056a4:	c3                   	ret
801056a5:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801056ac:	00 
801056ad:	8d 76 00             	lea    0x0(%esi),%esi

801056b0 <sys_pipe>:

int
sys_pipe(void)
{
801056b0:	55                   	push   %ebp
801056b1:	89 e5                	mov    %esp,%ebp
801056b3:	57                   	push   %edi
801056b4:	56                   	push   %esi
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
801056b5:	8d 45 dc             	lea    -0x24(%ebp),%eax
{
801056b8:	53                   	push   %ebx
801056b9:	83 ec 20             	sub    $0x20,%esp
  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
801056bc:	6a 08                	push   $0x8
801056be:	50                   	push   %eax
801056bf:	6a 00                	push   $0x0
801056c1:	e8 da f3 ff ff       	call   80104aa0 <argptr>
801056c6:	83 c4 10             	add    $0x10,%esp
801056c9:	85 c0                	test   %eax,%eax
801056cb:	0f 88 8b 00 00 00    	js     8010575c <sys_pipe+0xac>
    return -1;
  if(pipealloc(&rf, &wf) < 0)
801056d1:	83 ec 08             	sub    $0x8,%esp
801056d4:	8d 45 e4             	lea    -0x1c(%ebp),%eax
801056d7:	50                   	push   %eax
801056d8:	8d 45 e0             	lea    -0x20(%ebp),%eax
801056db:	50                   	push   %eax
801056dc:	e8 9f dd ff ff       	call   80103480 <pipealloc>
801056e1:	83 c4 10             	add    $0x10,%esp
801056e4:	85 c0                	test   %eax,%eax
801056e6:	78 74                	js     8010575c <sys_pipe+0xac>
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
801056e8:	8b 7d e0             	mov    -0x20(%ebp),%edi
  for(fd = 0; fd < NOFILE; fd++){
801056eb:	31 db                	xor    %ebx,%ebx
  struct proc *curproc = myproc();
801056ed:	e8 de e2 ff ff       	call   801039d0 <myproc>
    if(curproc->ofile[fd] == 0){
801056f2:	8b 74 98 28          	mov    0x28(%eax,%ebx,4),%esi
801056f6:	85 f6                	test   %esi,%esi
801056f8:	74 16                	je     80105710 <sys_pipe+0x60>
801056fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(fd = 0; fd < NOFILE; fd++){
80105700:	83 c3 01             	add    $0x1,%ebx
80105703:	83 fb 10             	cmp    $0x10,%ebx
80105706:	74 3d                	je     80105745 <sys_pipe+0x95>
    if(curproc->ofile[fd] == 0){
80105708:	8b 74 98 28          	mov    0x28(%eax,%ebx,4),%esi
8010570c:	85 f6                	test   %esi,%esi
8010570e:	75 f0                	jne    80105700 <sys_pipe+0x50>
      curproc->ofile[fd] = f;
80105710:	8d 73 08             	lea    0x8(%ebx),%esi
80105713:	89 7c b0 08          	mov    %edi,0x8(%eax,%esi,4)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80105717:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  struct proc *curproc = myproc();
8010571a:	e8 b1 e2 ff ff       	call   801039d0 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
8010571f:	31 d2                	xor    %edx,%edx
80105721:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(curproc->ofile[fd] == 0){
80105728:	8b 4c 90 28          	mov    0x28(%eax,%edx,4),%ecx
8010572c:	85 c9                	test   %ecx,%ecx
8010572e:	74 38                	je     80105768 <sys_pipe+0xb8>
  for(fd = 0; fd < NOFILE; fd++){
80105730:	83 c2 01             	add    $0x1,%edx
80105733:	83 fa 10             	cmp    $0x10,%edx
80105736:	75 f0                	jne    80105728 <sys_pipe+0x78>
    if(fd0 >= 0)
      myproc()->ofile[fd0] = 0;
80105738:	e8 93 e2 ff ff       	call   801039d0 <myproc>
8010573d:	c7 44 b0 08 00 00 00 	movl   $0x0,0x8(%eax,%esi,4)
80105744:	00 
    fileclose(rf);
80105745:	83 ec 0c             	sub    $0xc,%esp
80105748:	ff 75 e0             	push   -0x20(%ebp)
8010574b:	e8 20 b8 ff ff       	call   80100f70 <fileclose>
    fileclose(wf);
80105750:	58                   	pop    %eax
80105751:	ff 75 e4             	push   -0x1c(%ebp)
80105754:	e8 17 b8 ff ff       	call   80100f70 <fileclose>
    return -1;
80105759:	83 c4 10             	add    $0x10,%esp
    return -1;
8010575c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105761:	eb 16                	jmp    80105779 <sys_pipe+0xc9>
80105763:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
      curproc->ofile[fd] = f;
80105768:	89 7c 90 28          	mov    %edi,0x28(%eax,%edx,4)
  }
  fd[0] = fd0;
8010576c:	8b 45 dc             	mov    -0x24(%ebp),%eax
8010576f:	89 18                	mov    %ebx,(%eax)
  fd[1] = fd1;
80105771:	8b 45 dc             	mov    -0x24(%ebp),%eax
80105774:	89 50 04             	mov    %edx,0x4(%eax)
  return 0;
80105777:	31 c0                	xor    %eax,%eax
}
80105779:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010577c:	5b                   	pop    %ebx
8010577d:	5e                   	pop    %esi
8010577e:	5f                   	pop    %edi
8010577f:	5d                   	pop    %ebp
80105780:	c3                   	ret
80105781:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105788:	00 
80105789:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105790 <sys_shmget>:


// Shared memory related system calls:
int 
sys_shmget(void)
{
80105790:	55                   	push   %ebp
80105791:	89 e5                	mov    %esp,%ebp
80105793:	83 ec 20             	sub    $0x20,%esp
        int key, size, shmflag;

        if(argint(0, &key) < 0)
80105796:	8d 45 ec             	lea    -0x14(%ebp),%eax
80105799:	50                   	push   %eax
8010579a:	6a 00                	push   $0x0
8010579c:	e8 af f2 ff ff       	call   80104a50 <argint>
801057a1:	83 c4 10             	add    $0x10,%esp
801057a4:	85 c0                	test   %eax,%eax
801057a6:	78 48                	js     801057f0 <sys_shmget+0x60>
                return -1;
        if(argint(1, &size) < 0)
801057a8:	83 ec 08             	sub    $0x8,%esp
801057ab:	8d 45 f0             	lea    -0x10(%ebp),%eax
801057ae:	50                   	push   %eax
801057af:	6a 01                	push   $0x1
801057b1:	e8 9a f2 ff ff       	call   80104a50 <argint>
801057b6:	83 c4 10             	add    $0x10,%esp
801057b9:	85 c0                	test   %eax,%eax
801057bb:	78 33                	js     801057f0 <sys_shmget+0x60>
                return -1;
        if(argint(2, &shmflag) < 0)
801057bd:	83 ec 08             	sub    $0x8,%esp
801057c0:	8d 45 f4             	lea    -0xc(%ebp),%eax
801057c3:	50                   	push   %eax
801057c4:	6a 02                	push   $0x2
801057c6:	e8 85 f2 ff ff       	call   80104a50 <argint>
801057cb:	83 c4 10             	add    $0x10,%esp
801057ce:	85 c0                	test   %eax,%eax
801057d0:	78 1e                	js     801057f0 <sys_shmget+0x60>
                return -1;

        return shmgetHelper(key, size, shmflag);
801057d2:	83 ec 04             	sub    $0x4,%esp
801057d5:	ff 75 f4             	push   -0xc(%ebp)
801057d8:	ff 75 f0             	push   -0x10(%ebp)
801057db:	ff 75 ec             	push   -0x14(%ebp)
801057de:	e8 dd 22 00 00       	call   80107ac0 <shmgetHelper>
801057e3:	83 c4 10             	add    $0x10,%esp
}
801057e6:	c9                   	leave
801057e7:	c3                   	ret
801057e8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801057ef:	00 
801057f0:	c9                   	leave
                return -1;
801057f1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801057f6:	c3                   	ret
801057f7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801057fe:	00 
801057ff:	90                   	nop

80105800 <sys_shmat>:

void*
sys_shmat(void)
{
80105800:	55                   	push   %ebp
80105801:	89 e5                	mov    %esp,%ebp
80105803:	83 ec 20             	sub    $0x20,%esp
        int shmid, shmflag, shmaddr;
        if(argint(0, &shmid) < 0)
80105806:	8d 45 ec             	lea    -0x14(%ebp),%eax
80105809:	50                   	push   %eax
8010580a:	6a 00                	push   $0x0
8010580c:	e8 3f f2 ff ff       	call   80104a50 <argint>
80105811:	83 c4 10             	add    $0x10,%esp
80105814:	89 c2                	mov    %eax,%edx
                return (void *)101;
80105816:	b8 65 00 00 00       	mov    $0x65,%eax
        if(argint(0, &shmid) < 0)
8010581b:	85 d2                	test   %edx,%edx
8010581d:	78 4c                	js     8010586b <sys_shmat+0x6b>
        if(argint(1, &shmaddr) < 0)
8010581f:	83 ec 08             	sub    $0x8,%esp
80105822:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105825:	50                   	push   %eax
80105826:	6a 01                	push   $0x1
80105828:	e8 23 f2 ff ff       	call   80104a50 <argint>
8010582d:	83 c4 10             	add    $0x10,%esp
80105830:	89 c2                	mov    %eax,%edx
                return (void *)102;
80105832:	b8 66 00 00 00       	mov    $0x66,%eax
        if(argint(1, &shmaddr) < 0)
80105837:	85 d2                	test   %edx,%edx
80105839:	78 30                	js     8010586b <sys_shmat+0x6b>
        if(argint(2, &shmflag) < 0)
8010583b:	83 ec 08             	sub    $0x8,%esp
8010583e:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105841:	50                   	push   %eax
80105842:	6a 02                	push   $0x2
80105844:	e8 07 f2 ff ff       	call   80104a50 <argint>
80105849:	83 c4 10             	add    $0x10,%esp
8010584c:	89 c2                	mov    %eax,%edx
                return (void *)103;
8010584e:	b8 67 00 00 00       	mov    $0x67,%eax
        if(argint(2, &shmflag) < 0)
80105853:	85 d2                	test   %edx,%edx
80105855:	78 14                	js     8010586b <sys_shmat+0x6b>

        return shmatHelper(shmid, shmaddr, shmflag);
80105857:	83 ec 04             	sub    $0x4,%esp
8010585a:	ff 75 f0             	push   -0x10(%ebp)
8010585d:	ff 75 f4             	push   -0xc(%ebp)
80105860:	ff 75 ec             	push   -0x14(%ebp)
80105863:	e8 58 23 00 00       	call   80107bc0 <shmatHelper>
80105868:	83 c4 10             	add    $0x10,%esp
}
8010586b:	c9                   	leave
8010586c:	c3                   	ret
8010586d:	8d 76 00             	lea    0x0(%esi),%esi

80105870 <sys_shmdt>:

int
sys_shmdt(void)
{
80105870:	55                   	push   %ebp
80105871:	89 e5                	mov    %esp,%ebp
80105873:	83 ec 20             	sub    $0x20,%esp
        int shmaddr;
        int val = argint(0, &shmaddr);
80105876:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105879:	50                   	push   %eax
8010587a:	6a 00                	push   $0x0
8010587c:	e8 cf f1 ff ff       	call   80104a50 <argint>
        if( val < 0){
80105881:	83 c4 10             	add    $0x10,%esp
80105884:	85 c0                	test   %eax,%eax
80105886:	78 18                	js     801058a0 <sys_shmdt+0x30>
                return -1;
        }
        return shmdtHelper(shmaddr);
80105888:	83 ec 0c             	sub    $0xc,%esp
8010588b:	ff 75 f4             	push   -0xc(%ebp)
8010588e:	e8 5d 24 00 00       	call   80107cf0 <shmdtHelper>
80105893:	83 c4 10             	add    $0x10,%esp
}
80105896:	c9                   	leave
80105897:	c3                   	ret
80105898:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010589f:	00 
801058a0:	c9                   	leave
                return -1;
801058a1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801058a6:	c3                   	ret
801058a7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801058ae:	00 
801058af:	90                   	nop

801058b0 <sys_shmctl>:

int
sys_shmctl(void)
{
801058b0:	55                   	push   %ebp
801058b1:	89 e5                	mov    %esp,%ebp
801058b3:	83 ec 20             	sub    $0x20,%esp
        int shmid, cmd;
        struct shmid_ds *buf;

        if(argint(0, &shmid) < 0)
801058b6:	8d 45 ec             	lea    -0x14(%ebp),%eax
801058b9:	50                   	push   %eax
801058ba:	6a 00                	push   $0x0
801058bc:	e8 8f f1 ff ff       	call   80104a50 <argint>
801058c1:	83 c4 10             	add    $0x10,%esp
801058c4:	85 c0                	test   %eax,%eax
801058c6:	78 48                	js     80105910 <sys_shmctl+0x60>
                return -1;
        if(argint(1, &cmd) < 0)
801058c8:	83 ec 08             	sub    $0x8,%esp
801058cb:	8d 45 f0             	lea    -0x10(%ebp),%eax
801058ce:	50                   	push   %eax
801058cf:	6a 01                	push   $0x1
801058d1:	e8 7a f1 ff ff       	call   80104a50 <argint>
801058d6:	83 c4 10             	add    $0x10,%esp
801058d9:	85 c0                	test   %eax,%eax
801058db:	78 33                	js     80105910 <sys_shmctl+0x60>
                return -1;
        if(argptr(2, (char **)&buf, sizeof(struct shmid_ds *)) < 0)
801058dd:	83 ec 04             	sub    $0x4,%esp
801058e0:	8d 45 f4             	lea    -0xc(%ebp),%eax
801058e3:	6a 04                	push   $0x4
801058e5:	50                   	push   %eax
801058e6:	6a 02                	push   $0x2
801058e8:	e8 b3 f1 ff ff       	call   80104aa0 <argptr>
801058ed:	83 c4 10             	add    $0x10,%esp
801058f0:	85 c0                	test   %eax,%eax
801058f2:	78 1c                	js     80105910 <sys_shmctl+0x60>
                return -1;

        return shmctlHelper(shmid, cmd, buf);
801058f4:	83 ec 04             	sub    $0x4,%esp
801058f7:	ff 75 f4             	push   -0xc(%ebp)
801058fa:	ff 75 f0             	push   -0x10(%ebp)
801058fd:	ff 75 ec             	push   -0x14(%ebp)
80105900:	e8 4b 25 00 00       	call   80107e50 <shmctlHelper>
80105905:	83 c4 10             	add    $0x10,%esp
}
80105908:	c9                   	leave
80105909:	c3                   	ret
8010590a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105910:	c9                   	leave
                return -1;
80105911:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105916:	c3                   	ret
80105917:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010591e:	00 
8010591f:	90                   	nop

80105920 <sys_shminfo>:

void
sys_shminfo(void)
{
        shminfoHelper();
80105920:	e9 eb 20 00 00       	jmp    80107a10 <shminfoHelper>
80105925:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010592c:	00 
8010592d:	8d 76 00             	lea    0x0(%esi),%esi

80105930 <sys_removeshm>:
        return;
}

int
sys_removeshm(void)
{
80105930:	55                   	push   %ebp
80105931:	89 e5                	mov    %esp,%ebp
80105933:	83 ec 20             	sub    $0x20,%esp
	int shm_identifier, flag;

	if(argint(0, &shm_identifier) < 0)
80105936:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105939:	50                   	push   %eax
8010593a:	6a 00                	push   $0x0
8010593c:	e8 0f f1 ff ff       	call   80104a50 <argint>
80105941:	83 c4 10             	add    $0x10,%esp
80105944:	85 c0                	test   %eax,%eax
80105946:	78 28                	js     80105970 <sys_removeshm+0x40>
		return -1;
	if(argint(1, &flag) < 0)
80105948:	83 ec 08             	sub    $0x8,%esp
8010594b:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010594e:	50                   	push   %eax
8010594f:	6a 01                	push   $0x1
80105951:	e8 fa f0 ff ff       	call   80104a50 <argint>
80105956:	83 c4 10             	add    $0x10,%esp
80105959:	85 c0                	test   %eax,%eax
8010595b:	78 13                	js     80105970 <sys_removeshm+0x40>
		return -1;

	return removeshmHelper(shm_identifier, flag);
8010595d:	83 ec 08             	sub    $0x8,%esp
80105960:	ff 75 f4             	push   -0xc(%ebp)
80105963:	ff 75 f0             	push   -0x10(%ebp)
80105966:	e8 d5 27 00 00       	call   80108140 <removeshmHelper>
8010596b:	83 c4 10             	add    $0x10,%esp
}
8010596e:	c9                   	leave
8010596f:	c3                   	ret
80105970:	c9                   	leave
		return -1;
80105971:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105976:	c3                   	ret
80105977:	66 90                	xchg   %ax,%ax
80105979:	66 90                	xchg   %ax,%ax
8010597b:	66 90                	xchg   %ax,%ax
8010597d:	66 90                	xchg   %ax,%ax
8010597f:	90                   	nop

80105980 <sys_fork>:
#include "proc.h"

int
sys_fork(void)
{
  return fork();
80105980:	e9 eb e1 ff ff       	jmp    80103b70 <fork>
80105985:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010598c:	00 
8010598d:	8d 76 00             	lea    0x0(%esi),%esi

80105990 <sys_exit>:
}

int
sys_exit(void)
{
80105990:	55                   	push   %ebp
80105991:	89 e5                	mov    %esp,%ebp
80105993:	83 ec 08             	sub    $0x8,%esp
  exit();
80105996:	e8 d5 e4 ff ff       	call   80103e70 <exit>
  return 0;  // not reached
}
8010599b:	31 c0                	xor    %eax,%eax
8010599d:	c9                   	leave
8010599e:	c3                   	ret
8010599f:	90                   	nop

801059a0 <sys_wait>:

int
sys_wait(void)
{
  return wait();
801059a0:	e9 fb e5 ff ff       	jmp    80103fa0 <wait>
801059a5:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801059ac:	00 
801059ad:	8d 76 00             	lea    0x0(%esi),%esi

801059b0 <sys_kill>:
}

int
sys_kill(void)
{
801059b0:	55                   	push   %ebp
801059b1:	89 e5                	mov    %esp,%ebp
801059b3:	83 ec 20             	sub    $0x20,%esp
  int pid;

  if(argint(0, &pid) < 0)
801059b6:	8d 45 f4             	lea    -0xc(%ebp),%eax
801059b9:	50                   	push   %eax
801059ba:	6a 00                	push   $0x0
801059bc:	e8 8f f0 ff ff       	call   80104a50 <argint>
801059c1:	83 c4 10             	add    $0x10,%esp
801059c4:	85 c0                	test   %eax,%eax
801059c6:	78 18                	js     801059e0 <sys_kill+0x30>
    return -1;
  return kill(pid);
801059c8:	83 ec 0c             	sub    $0xc,%esp
801059cb:	ff 75 f4             	push   -0xc(%ebp)
801059ce:	e8 6d e8 ff ff       	call   80104240 <kill>
801059d3:	83 c4 10             	add    $0x10,%esp
}
801059d6:	c9                   	leave
801059d7:	c3                   	ret
801059d8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801059df:	00 
801059e0:	c9                   	leave
    return -1;
801059e1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801059e6:	c3                   	ret
801059e7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801059ee:	00 
801059ef:	90                   	nop

801059f0 <sys_getpid>:

int
sys_getpid(void)
{
801059f0:	55                   	push   %ebp
801059f1:	89 e5                	mov    %esp,%ebp
801059f3:	83 ec 08             	sub    $0x8,%esp
  return myproc()->pid;
801059f6:	e8 d5 df ff ff       	call   801039d0 <myproc>
801059fb:	8b 40 10             	mov    0x10(%eax),%eax
}
801059fe:	c9                   	leave
801059ff:	c3                   	ret

80105a00 <sys_sbrk>:

int
sys_sbrk(void)
{
80105a00:	55                   	push   %ebp
80105a01:	89 e5                	mov    %esp,%ebp
80105a03:	53                   	push   %ebx
  int addr;
  int n;

  if(argint(0, &n) < 0)
80105a04:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80105a07:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
80105a0a:	50                   	push   %eax
80105a0b:	6a 00                	push   $0x0
80105a0d:	e8 3e f0 ff ff       	call   80104a50 <argint>
80105a12:	83 c4 10             	add    $0x10,%esp
80105a15:	85 c0                	test   %eax,%eax
80105a17:	78 27                	js     80105a40 <sys_sbrk+0x40>
    return -1;
  addr = myproc()->sz;
80105a19:	e8 b2 df ff ff       	call   801039d0 <myproc>
  if(growproc(n) < 0)
80105a1e:	83 ec 0c             	sub    $0xc,%esp
  addr = myproc()->sz;
80105a21:	8b 18                	mov    (%eax),%ebx
  if(growproc(n) < 0)
80105a23:	ff 75 f4             	push   -0xc(%ebp)
80105a26:	e8 c5 e0 ff ff       	call   80103af0 <growproc>
80105a2b:	83 c4 10             	add    $0x10,%esp
80105a2e:	85 c0                	test   %eax,%eax
80105a30:	78 0e                	js     80105a40 <sys_sbrk+0x40>
    return -1;
  return addr;
}
80105a32:	89 d8                	mov    %ebx,%eax
80105a34:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105a37:	c9                   	leave
80105a38:	c3                   	ret
80105a39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105a40:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80105a45:	eb eb                	jmp    80105a32 <sys_sbrk+0x32>
80105a47:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105a4e:	00 
80105a4f:	90                   	nop

80105a50 <sys_sleep>:

int
sys_sleep(void)
{
80105a50:	55                   	push   %ebp
80105a51:	89 e5                	mov    %esp,%ebp
80105a53:	53                   	push   %ebx
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
80105a54:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80105a57:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
80105a5a:	50                   	push   %eax
80105a5b:	6a 00                	push   $0x0
80105a5d:	e8 ee ef ff ff       	call   80104a50 <argint>
80105a62:	83 c4 10             	add    $0x10,%esp
80105a65:	85 c0                	test   %eax,%eax
80105a67:	78 64                	js     80105acd <sys_sleep+0x7d>
    return -1;
  acquire(&tickslock);
80105a69:	83 ec 0c             	sub    $0xc,%esp
80105a6c:	68 e0 cc 33 80       	push   $0x8033cce0
80105a71:	e8 2a ec ff ff       	call   801046a0 <acquire>
  ticks0 = ticks;
  while(ticks - ticks0 < n){
80105a76:	8b 55 f4             	mov    -0xc(%ebp),%edx
  ticks0 = ticks;
80105a79:	8b 1d c0 cc 33 80    	mov    0x8033ccc0,%ebx
  while(ticks - ticks0 < n){
80105a7f:	83 c4 10             	add    $0x10,%esp
80105a82:	85 d2                	test   %edx,%edx
80105a84:	75 2b                	jne    80105ab1 <sys_sleep+0x61>
80105a86:	eb 58                	jmp    80105ae0 <sys_sleep+0x90>
80105a88:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105a8f:	00 
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
80105a90:	83 ec 08             	sub    $0x8,%esp
80105a93:	68 e0 cc 33 80       	push   $0x8033cce0
80105a98:	68 c0 cc 33 80       	push   $0x8033ccc0
80105a9d:	e8 7e e6 ff ff       	call   80104120 <sleep>
  while(ticks - ticks0 < n){
80105aa2:	a1 c0 cc 33 80       	mov    0x8033ccc0,%eax
80105aa7:	83 c4 10             	add    $0x10,%esp
80105aaa:	29 d8                	sub    %ebx,%eax
80105aac:	3b 45 f4             	cmp    -0xc(%ebp),%eax
80105aaf:	73 2f                	jae    80105ae0 <sys_sleep+0x90>
    if(myproc()->killed){
80105ab1:	e8 1a df ff ff       	call   801039d0 <myproc>
80105ab6:	8b 40 24             	mov    0x24(%eax),%eax
80105ab9:	85 c0                	test   %eax,%eax
80105abb:	74 d3                	je     80105a90 <sys_sleep+0x40>
      release(&tickslock);
80105abd:	83 ec 0c             	sub    $0xc,%esp
80105ac0:	68 e0 cc 33 80       	push   $0x8033cce0
80105ac5:	e8 76 eb ff ff       	call   80104640 <release>
      return -1;
80105aca:	83 c4 10             	add    $0x10,%esp
  }
  release(&tickslock);
  return 0;
}
80105acd:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    return -1;
80105ad0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105ad5:	c9                   	leave
80105ad6:	c3                   	ret
80105ad7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105ade:	00 
80105adf:	90                   	nop
  release(&tickslock);
80105ae0:	83 ec 0c             	sub    $0xc,%esp
80105ae3:	68 e0 cc 33 80       	push   $0x8033cce0
80105ae8:	e8 53 eb ff ff       	call   80104640 <release>
}
80105aed:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  return 0;
80105af0:	83 c4 10             	add    $0x10,%esp
80105af3:	31 c0                	xor    %eax,%eax
}
80105af5:	c9                   	leave
80105af6:	c3                   	ret
80105af7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105afe:	00 
80105aff:	90                   	nop

80105b00 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
80105b00:	55                   	push   %ebp
80105b01:	89 e5                	mov    %esp,%ebp
80105b03:	53                   	push   %ebx
80105b04:	83 ec 10             	sub    $0x10,%esp
  uint xticks;

  acquire(&tickslock);
80105b07:	68 e0 cc 33 80       	push   $0x8033cce0
80105b0c:	e8 8f eb ff ff       	call   801046a0 <acquire>
  xticks = ticks;
80105b11:	8b 1d c0 cc 33 80    	mov    0x8033ccc0,%ebx
  release(&tickslock);
80105b17:	c7 04 24 e0 cc 33 80 	movl   $0x8033cce0,(%esp)
80105b1e:	e8 1d eb ff ff       	call   80104640 <release>
  return xticks;
}
80105b23:	89 d8                	mov    %ebx,%eax
80105b25:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105b28:	c9                   	leave
80105b29:	c3                   	ret

80105b2a <alltraps>:

  # vectors.S sends all traps here.
.globl alltraps
alltraps:
  # Build trap frame.
  pushl %ds
80105b2a:	1e                   	push   %ds
  pushl %es
80105b2b:	06                   	push   %es
  pushl %fs
80105b2c:	0f a0                	push   %fs
  pushl %gs
80105b2e:	0f a8                	push   %gs
  pushal
80105b30:	60                   	pusha
  
  # Set up data segments.
  movw $(SEG_KDATA<<3), %ax
80105b31:	66 b8 10 00          	mov    $0x10,%ax
  movw %ax, %ds
80105b35:	8e d8                	mov    %eax,%ds
  movw %ax, %es
80105b37:	8e c0                	mov    %eax,%es

  # Call trap(tf), where tf=%esp
  pushl %esp
80105b39:	54                   	push   %esp
  call trap
80105b3a:	e8 c1 00 00 00       	call   80105c00 <trap>
  addl $4, %esp
80105b3f:	83 c4 04             	add    $0x4,%esp

80105b42 <trapret>:

  # Return falls through to trapret...
.globl trapret
trapret:
  popal
80105b42:	61                   	popa
  popl %gs
80105b43:	0f a9                	pop    %gs
  popl %fs
80105b45:	0f a1                	pop    %fs
  popl %es
80105b47:	07                   	pop    %es
  popl %ds
80105b48:	1f                   	pop    %ds
  addl $0x8, %esp  # trapno and errcode
80105b49:	83 c4 08             	add    $0x8,%esp
  iret
80105b4c:	cf                   	iret
80105b4d:	66 90                	xchg   %ax,%ax
80105b4f:	90                   	nop

80105b50 <tvinit>:
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
80105b50:	55                   	push   %ebp
  int i;

  for(i = 0; i < 256; i++)
80105b51:	31 c0                	xor    %eax,%eax
{
80105b53:	89 e5                	mov    %esp,%ebp
80105b55:	83 ec 08             	sub    $0x8,%esp
80105b58:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105b5f:	00 
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
80105b60:	8b 14 85 08 b0 10 80 	mov    -0x7fef4ff8(,%eax,4),%edx
80105b67:	c7 04 c5 22 cd 33 80 	movl   $0x8e000008,-0x7fcc32de(,%eax,8)
80105b6e:	08 00 00 8e 
80105b72:	66 89 14 c5 20 cd 33 	mov    %dx,-0x7fcc32e0(,%eax,8)
80105b79:	80 
80105b7a:	c1 ea 10             	shr    $0x10,%edx
80105b7d:	66 89 14 c5 26 cd 33 	mov    %dx,-0x7fcc32da(,%eax,8)
80105b84:	80 
  for(i = 0; i < 256; i++)
80105b85:	83 c0 01             	add    $0x1,%eax
80105b88:	3d 00 01 00 00       	cmp    $0x100,%eax
80105b8d:	75 d1                	jne    80105b60 <tvinit+0x10>
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);

  initlock(&tickslock, "time");
80105b8f:	83 ec 08             	sub    $0x8,%esp
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80105b92:	a1 08 b1 10 80       	mov    0x8010b108,%eax
80105b97:	c7 05 22 cf 33 80 08 	movl   $0xef000008,0x8033cf22
80105b9e:	00 00 ef 
  initlock(&tickslock, "time");
80105ba1:	68 4e 86 10 80       	push   $0x8010864e
80105ba6:	68 e0 cc 33 80       	push   $0x8033cce0
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80105bab:	66 a3 20 cf 33 80    	mov    %ax,0x8033cf20
80105bb1:	c1 e8 10             	shr    $0x10,%eax
80105bb4:	66 a3 26 cf 33 80    	mov    %ax,0x8033cf26
  initlock(&tickslock, "time");
80105bba:	e8 f1 e8 ff ff       	call   801044b0 <initlock>
}
80105bbf:	83 c4 10             	add    $0x10,%esp
80105bc2:	c9                   	leave
80105bc3:	c3                   	ret
80105bc4:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105bcb:	00 
80105bcc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105bd0 <idtinit>:

void
idtinit(void)
{
80105bd0:	55                   	push   %ebp
  pd[0] = size-1;
80105bd1:	b8 ff 07 00 00       	mov    $0x7ff,%eax
80105bd6:	89 e5                	mov    %esp,%ebp
80105bd8:	83 ec 10             	sub    $0x10,%esp
80105bdb:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
80105bdf:	b8 20 cd 33 80       	mov    $0x8033cd20,%eax
80105be4:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
80105be8:	c1 e8 10             	shr    $0x10,%eax
80105beb:	66 89 45 fe          	mov    %ax,-0x2(%ebp)
  asm volatile("lidt (%0)" : : "r" (pd));
80105bef:	8d 45 fa             	lea    -0x6(%ebp),%eax
80105bf2:	0f 01 18             	lidtl  (%eax)
  lidt(idt, sizeof(idt));
}
80105bf5:	c9                   	leave
80105bf6:	c3                   	ret
80105bf7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105bfe:	00 
80105bff:	90                   	nop

80105c00 <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
80105c00:	55                   	push   %ebp
80105c01:	89 e5                	mov    %esp,%ebp
80105c03:	57                   	push   %edi
80105c04:	56                   	push   %esi
80105c05:	53                   	push   %ebx
80105c06:	83 ec 1c             	sub    $0x1c,%esp
80105c09:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(tf->trapno == T_SYSCALL){
80105c0c:	8b 43 30             	mov    0x30(%ebx),%eax
80105c0f:	83 f8 40             	cmp    $0x40,%eax
80105c12:	0f 84 58 01 00 00    	je     80105d70 <trap+0x170>
    if(myproc()->killed)
      exit();
    return;
  }

  switch(tf->trapno){
80105c18:	83 e8 20             	sub    $0x20,%eax
80105c1b:	83 f8 1f             	cmp    $0x1f,%eax
80105c1e:	0f 87 7c 00 00 00    	ja     80105ca0 <trap+0xa0>
80105c24:	ff 24 85 50 8d 10 80 	jmp    *-0x7fef72b0(,%eax,4)
80105c2b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
      release(&tickslock);
    }
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_IDE:
    ideintr();
80105c30:	e8 5b c6 ff ff       	call   80102290 <ideintr>
    lapiceoi();
80105c35:	e8 16 cd ff ff       	call   80102950 <lapiceoi>
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105c3a:	e8 91 dd ff ff       	call   801039d0 <myproc>
80105c3f:	85 c0                	test   %eax,%eax
80105c41:	74 1a                	je     80105c5d <trap+0x5d>
80105c43:	e8 88 dd ff ff       	call   801039d0 <myproc>
80105c48:	8b 50 24             	mov    0x24(%eax),%edx
80105c4b:	85 d2                	test   %edx,%edx
80105c4d:	74 0e                	je     80105c5d <trap+0x5d>
80105c4f:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
80105c53:	f7 d0                	not    %eax
80105c55:	a8 03                	test   $0x3,%al
80105c57:	0f 84 db 01 00 00    	je     80105e38 <trap+0x238>
    exit();

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(myproc() && myproc()->state == RUNNING &&
80105c5d:	e8 6e dd ff ff       	call   801039d0 <myproc>
80105c62:	85 c0                	test   %eax,%eax
80105c64:	74 0f                	je     80105c75 <trap+0x75>
80105c66:	e8 65 dd ff ff       	call   801039d0 <myproc>
80105c6b:	83 78 0c 04          	cmpl   $0x4,0xc(%eax)
80105c6f:	0f 84 ab 00 00 00    	je     80105d20 <trap+0x120>
     tf->trapno == T_IRQ0+IRQ_TIMER)
    yield();

  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105c75:	e8 56 dd ff ff       	call   801039d0 <myproc>
80105c7a:	85 c0                	test   %eax,%eax
80105c7c:	74 1a                	je     80105c98 <trap+0x98>
80105c7e:	e8 4d dd ff ff       	call   801039d0 <myproc>
80105c83:	8b 40 24             	mov    0x24(%eax),%eax
80105c86:	85 c0                	test   %eax,%eax
80105c88:	74 0e                	je     80105c98 <trap+0x98>
80105c8a:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
80105c8e:	f7 d0                	not    %eax
80105c90:	a8 03                	test   $0x3,%al
80105c92:	0f 84 05 01 00 00    	je     80105d9d <trap+0x19d>
    exit();
}
80105c98:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105c9b:	5b                   	pop    %ebx
80105c9c:	5e                   	pop    %esi
80105c9d:	5f                   	pop    %edi
80105c9e:	5d                   	pop    %ebp
80105c9f:	c3                   	ret
    if(myproc() == 0 || (tf->cs&3) == 0){
80105ca0:	e8 2b dd ff ff       	call   801039d0 <myproc>
80105ca5:	8b 7b 38             	mov    0x38(%ebx),%edi
80105ca8:	85 c0                	test   %eax,%eax
80105caa:	0f 84 a2 01 00 00    	je     80105e52 <trap+0x252>
80105cb0:	f6 43 3c 03          	testb  $0x3,0x3c(%ebx)
80105cb4:	0f 84 98 01 00 00    	je     80105e52 <trap+0x252>

static inline uint
rcr2(void)
{
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
80105cba:	0f 20 d1             	mov    %cr2,%ecx
80105cbd:	89 4d d8             	mov    %ecx,-0x28(%ebp)
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105cc0:	e8 eb dc ff ff       	call   801039b0 <cpuid>
80105cc5:	8b 73 30             	mov    0x30(%ebx),%esi
80105cc8:	89 45 dc             	mov    %eax,-0x24(%ebp)
80105ccb:	8b 43 34             	mov    0x34(%ebx),%eax
80105cce:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            myproc()->pid, myproc()->name, tf->trapno,
80105cd1:	e8 fa dc ff ff       	call   801039d0 <myproc>
80105cd6:	89 45 e0             	mov    %eax,-0x20(%ebp)
80105cd9:	e8 f2 dc ff ff       	call   801039d0 <myproc>
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105cde:	8b 4d d8             	mov    -0x28(%ebp),%ecx
80105ce1:	51                   	push   %ecx
80105ce2:	57                   	push   %edi
80105ce3:	8b 55 dc             	mov    -0x24(%ebp),%edx
80105ce6:	52                   	push   %edx
80105ce7:	ff 75 e4             	push   -0x1c(%ebp)
80105cea:	56                   	push   %esi
            myproc()->pid, myproc()->name, tf->trapno,
80105ceb:	8b 75 e0             	mov    -0x20(%ebp),%esi
80105cee:	83 c6 6c             	add    $0x6c,%esi
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105cf1:	56                   	push   %esi
80105cf2:	ff 70 10             	push   0x10(%eax)
80105cf5:	68 a0 89 10 80       	push   $0x801089a0
80105cfa:	e8 b1 a9 ff ff       	call   801006b0 <cprintf>
    myproc()->killed = 1;
80105cff:	83 c4 20             	add    $0x20,%esp
80105d02:	e8 c9 dc ff ff       	call   801039d0 <myproc>
80105d07:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105d0e:	e8 bd dc ff ff       	call   801039d0 <myproc>
80105d13:	85 c0                	test   %eax,%eax
80105d15:	0f 85 28 ff ff ff    	jne    80105c43 <trap+0x43>
80105d1b:	e9 3d ff ff ff       	jmp    80105c5d <trap+0x5d>
  if(myproc() && myproc()->state == RUNNING &&
80105d20:	83 7b 30 20          	cmpl   $0x20,0x30(%ebx)
80105d24:	0f 85 4b ff ff ff    	jne    80105c75 <trap+0x75>
    yield();
80105d2a:	e8 a1 e3 ff ff       	call   801040d0 <yield>
80105d2f:	e9 41 ff ff ff       	jmp    80105c75 <trap+0x75>
80105d34:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
80105d38:	8b 7b 38             	mov    0x38(%ebx),%edi
80105d3b:	0f b7 73 3c          	movzwl 0x3c(%ebx),%esi
80105d3f:	e8 6c dc ff ff       	call   801039b0 <cpuid>
80105d44:	57                   	push   %edi
80105d45:	56                   	push   %esi
80105d46:	50                   	push   %eax
80105d47:	68 48 89 10 80       	push   $0x80108948
80105d4c:	e8 5f a9 ff ff       	call   801006b0 <cprintf>
    lapiceoi();
80105d51:	e8 fa cb ff ff       	call   80102950 <lapiceoi>
    break;
80105d56:	83 c4 10             	add    $0x10,%esp
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105d59:	e8 72 dc ff ff       	call   801039d0 <myproc>
80105d5e:	85 c0                	test   %eax,%eax
80105d60:	0f 85 dd fe ff ff    	jne    80105c43 <trap+0x43>
80105d66:	e9 f2 fe ff ff       	jmp    80105c5d <trap+0x5d>
80105d6b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    if(myproc()->killed)
80105d70:	e8 5b dc ff ff       	call   801039d0 <myproc>
80105d75:	8b 70 24             	mov    0x24(%eax),%esi
80105d78:	85 f6                	test   %esi,%esi
80105d7a:	0f 85 c8 00 00 00    	jne    80105e48 <trap+0x248>
    myproc()->tf = tf;
80105d80:	e8 4b dc ff ff       	call   801039d0 <myproc>
80105d85:	89 58 18             	mov    %ebx,0x18(%eax)
    syscall();
80105d88:	e8 03 ee ff ff       	call   80104b90 <syscall>
    if(myproc()->killed)
80105d8d:	e8 3e dc ff ff       	call   801039d0 <myproc>
80105d92:	8b 48 24             	mov    0x24(%eax),%ecx
80105d95:	85 c9                	test   %ecx,%ecx
80105d97:	0f 84 fb fe ff ff    	je     80105c98 <trap+0x98>
}
80105d9d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105da0:	5b                   	pop    %ebx
80105da1:	5e                   	pop    %esi
80105da2:	5f                   	pop    %edi
80105da3:	5d                   	pop    %ebp
      exit();
80105da4:	e9 c7 e0 ff ff       	jmp    80103e70 <exit>
80105da9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    uartintr();
80105db0:	e8 4b 02 00 00       	call   80106000 <uartintr>
    lapiceoi();
80105db5:	e8 96 cb ff ff       	call   80102950 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105dba:	e8 11 dc ff ff       	call   801039d0 <myproc>
80105dbf:	85 c0                	test   %eax,%eax
80105dc1:	0f 85 7c fe ff ff    	jne    80105c43 <trap+0x43>
80105dc7:	e9 91 fe ff ff       	jmp    80105c5d <trap+0x5d>
80105dcc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    kbdintr();
80105dd0:	e8 4b ca ff ff       	call   80102820 <kbdintr>
    lapiceoi();
80105dd5:	e8 76 cb ff ff       	call   80102950 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105dda:	e8 f1 db ff ff       	call   801039d0 <myproc>
80105ddf:	85 c0                	test   %eax,%eax
80105de1:	0f 85 5c fe ff ff    	jne    80105c43 <trap+0x43>
80105de7:	e9 71 fe ff ff       	jmp    80105c5d <trap+0x5d>
80105dec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(cpuid() == 0){
80105df0:	e8 bb db ff ff       	call   801039b0 <cpuid>
80105df5:	85 c0                	test   %eax,%eax
80105df7:	0f 85 38 fe ff ff    	jne    80105c35 <trap+0x35>
      acquire(&tickslock);
80105dfd:	83 ec 0c             	sub    $0xc,%esp
80105e00:	68 e0 cc 33 80       	push   $0x8033cce0
80105e05:	e8 96 e8 ff ff       	call   801046a0 <acquire>
      ticks++;
80105e0a:	83 05 c0 cc 33 80 01 	addl   $0x1,0x8033ccc0
      wakeup(&ticks);
80105e11:	c7 04 24 c0 cc 33 80 	movl   $0x8033ccc0,(%esp)
80105e18:	e8 c3 e3 ff ff       	call   801041e0 <wakeup>
      release(&tickslock);
80105e1d:	c7 04 24 e0 cc 33 80 	movl   $0x8033cce0,(%esp)
80105e24:	e8 17 e8 ff ff       	call   80104640 <release>
80105e29:	83 c4 10             	add    $0x10,%esp
    lapiceoi();
80105e2c:	e9 04 fe ff ff       	jmp    80105c35 <trap+0x35>
80105e31:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    exit();
80105e38:	e8 33 e0 ff ff       	call   80103e70 <exit>
80105e3d:	e9 1b fe ff ff       	jmp    80105c5d <trap+0x5d>
80105e42:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      exit();
80105e48:	e8 23 e0 ff ff       	call   80103e70 <exit>
80105e4d:	e9 2e ff ff ff       	jmp    80105d80 <trap+0x180>
80105e52:	0f 20 d6             	mov    %cr2,%esi
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
80105e55:	e8 56 db ff ff       	call   801039b0 <cpuid>
80105e5a:	83 ec 0c             	sub    $0xc,%esp
80105e5d:	56                   	push   %esi
80105e5e:	57                   	push   %edi
80105e5f:	50                   	push   %eax
80105e60:	ff 73 30             	push   0x30(%ebx)
80105e63:	68 6c 89 10 80       	push   $0x8010896c
80105e68:	e8 43 a8 ff ff       	call   801006b0 <cprintf>
      panic("trap");
80105e6d:	83 c4 14             	add    $0x14,%esp
80105e70:	68 53 86 10 80       	push   $0x80108653
80105e75:	e8 06 a5 ff ff       	call   80100380 <panic>
80105e7a:	66 90                	xchg   %ax,%ax
80105e7c:	66 90                	xchg   %ax,%ax
80105e7e:	66 90                	xchg   %ax,%ax

80105e80 <uartgetc>:
}

static int
uartgetc(void)
{
  if(!uart)
80105e80:	a1 20 d5 33 80       	mov    0x8033d520,%eax
80105e85:	85 c0                	test   %eax,%eax
80105e87:	74 17                	je     80105ea0 <uartgetc+0x20>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80105e89:	ba fd 03 00 00       	mov    $0x3fd,%edx
80105e8e:	ec                   	in     (%dx),%al
    return -1;
  if(!(inb(COM1+5) & 0x01))
80105e8f:	a8 01                	test   $0x1,%al
80105e91:	74 0d                	je     80105ea0 <uartgetc+0x20>
80105e93:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105e98:	ec                   	in     (%dx),%al
    return -1;
  return inb(COM1+0);
80105e99:	0f b6 c0             	movzbl %al,%eax
80105e9c:	c3                   	ret
80105e9d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
80105ea0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105ea5:	c3                   	ret
80105ea6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105ead:	00 
80105eae:	66 90                	xchg   %ax,%ax

80105eb0 <uartinit>:
{
80105eb0:	55                   	push   %ebp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80105eb1:	31 c9                	xor    %ecx,%ecx
80105eb3:	89 c8                	mov    %ecx,%eax
80105eb5:	89 e5                	mov    %esp,%ebp
80105eb7:	57                   	push   %edi
80105eb8:	bf fa 03 00 00       	mov    $0x3fa,%edi
80105ebd:	56                   	push   %esi
80105ebe:	89 fa                	mov    %edi,%edx
80105ec0:	53                   	push   %ebx
80105ec1:	83 ec 1c             	sub    $0x1c,%esp
80105ec4:	ee                   	out    %al,(%dx)
80105ec5:	be fb 03 00 00       	mov    $0x3fb,%esi
80105eca:	b8 80 ff ff ff       	mov    $0xffffff80,%eax
80105ecf:	89 f2                	mov    %esi,%edx
80105ed1:	ee                   	out    %al,(%dx)
80105ed2:	b8 0c 00 00 00       	mov    $0xc,%eax
80105ed7:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105edc:	ee                   	out    %al,(%dx)
80105edd:	bb f9 03 00 00       	mov    $0x3f9,%ebx
80105ee2:	89 c8                	mov    %ecx,%eax
80105ee4:	89 da                	mov    %ebx,%edx
80105ee6:	ee                   	out    %al,(%dx)
80105ee7:	b8 03 00 00 00       	mov    $0x3,%eax
80105eec:	89 f2                	mov    %esi,%edx
80105eee:	ee                   	out    %al,(%dx)
80105eef:	ba fc 03 00 00       	mov    $0x3fc,%edx
80105ef4:	89 c8                	mov    %ecx,%eax
80105ef6:	ee                   	out    %al,(%dx)
80105ef7:	b8 01 00 00 00       	mov    $0x1,%eax
80105efc:	89 da                	mov    %ebx,%edx
80105efe:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80105eff:	ba fd 03 00 00       	mov    $0x3fd,%edx
80105f04:	ec                   	in     (%dx),%al
  if(inb(COM1+5) == 0xFF)
80105f05:	3c ff                	cmp    $0xff,%al
80105f07:	0f 84 7c 00 00 00    	je     80105f89 <uartinit+0xd9>
  uart = 1;
80105f0d:	c7 05 20 d5 33 80 01 	movl   $0x1,0x8033d520
80105f14:	00 00 00 
80105f17:	89 fa                	mov    %edi,%edx
80105f19:	ec                   	in     (%dx),%al
80105f1a:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105f1f:	ec                   	in     (%dx),%al
  ioapicenable(IRQ_COM1, 0);
80105f20:	83 ec 08             	sub    $0x8,%esp
  for(p="xv6...\n"; *p; p++)
80105f23:	bf 58 86 10 80       	mov    $0x80108658,%edi
80105f28:	be fd 03 00 00       	mov    $0x3fd,%esi
  ioapicenable(IRQ_COM1, 0);
80105f2d:	6a 00                	push   $0x0
80105f2f:	6a 04                	push   $0x4
80105f31:	e8 8a c5 ff ff       	call   801024c0 <ioapicenable>
80105f36:	83 c4 10             	add    $0x10,%esp
  for(p="xv6...\n"; *p; p++)
80105f39:	c6 45 e7 78          	movb   $0x78,-0x19(%ebp)
80105f3d:	8d 76 00             	lea    0x0(%esi),%esi
  if(!uart)
80105f40:	a1 20 d5 33 80       	mov    0x8033d520,%eax
80105f45:	85 c0                	test   %eax,%eax
80105f47:	74 32                	je     80105f7b <uartinit+0xcb>
80105f49:	89 f2                	mov    %esi,%edx
80105f4b:	ec                   	in     (%dx),%al
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
80105f4c:	a8 20                	test   $0x20,%al
80105f4e:	75 21                	jne    80105f71 <uartinit+0xc1>
80105f50:	bb 80 00 00 00       	mov    $0x80,%ebx
80105f55:	8d 76 00             	lea    0x0(%esi),%esi
    microdelay(10);
80105f58:	83 ec 0c             	sub    $0xc,%esp
80105f5b:	6a 0a                	push   $0xa
80105f5d:	e8 0e ca ff ff       	call   80102970 <microdelay>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
80105f62:	83 c4 10             	add    $0x10,%esp
80105f65:	83 eb 01             	sub    $0x1,%ebx
80105f68:	74 07                	je     80105f71 <uartinit+0xc1>
80105f6a:	89 f2                	mov    %esi,%edx
80105f6c:	ec                   	in     (%dx),%al
80105f6d:	a8 20                	test   $0x20,%al
80105f6f:	74 e7                	je     80105f58 <uartinit+0xa8>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80105f71:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105f76:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
80105f7a:	ee                   	out    %al,(%dx)
  for(p="xv6...\n"; *p; p++)
80105f7b:	0f b6 47 01          	movzbl 0x1(%edi),%eax
80105f7f:	83 c7 01             	add    $0x1,%edi
80105f82:	88 45 e7             	mov    %al,-0x19(%ebp)
80105f85:	84 c0                	test   %al,%al
80105f87:	75 b7                	jne    80105f40 <uartinit+0x90>
}
80105f89:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105f8c:	5b                   	pop    %ebx
80105f8d:	5e                   	pop    %esi
80105f8e:	5f                   	pop    %edi
80105f8f:	5d                   	pop    %ebp
80105f90:	c3                   	ret
80105f91:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105f98:	00 
80105f99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105fa0 <uartputc>:
  if(!uart)
80105fa0:	a1 20 d5 33 80       	mov    0x8033d520,%eax
80105fa5:	85 c0                	test   %eax,%eax
80105fa7:	74 4f                	je     80105ff8 <uartputc+0x58>
{
80105fa9:	55                   	push   %ebp
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80105faa:	ba fd 03 00 00       	mov    $0x3fd,%edx
80105faf:	89 e5                	mov    %esp,%ebp
80105fb1:	56                   	push   %esi
80105fb2:	53                   	push   %ebx
80105fb3:	ec                   	in     (%dx),%al
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
80105fb4:	a8 20                	test   $0x20,%al
80105fb6:	75 29                	jne    80105fe1 <uartputc+0x41>
80105fb8:	bb 80 00 00 00       	mov    $0x80,%ebx
80105fbd:	be fd 03 00 00       	mov    $0x3fd,%esi
80105fc2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    microdelay(10);
80105fc8:	83 ec 0c             	sub    $0xc,%esp
80105fcb:	6a 0a                	push   $0xa
80105fcd:	e8 9e c9 ff ff       	call   80102970 <microdelay>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
80105fd2:	83 c4 10             	add    $0x10,%esp
80105fd5:	83 eb 01             	sub    $0x1,%ebx
80105fd8:	74 07                	je     80105fe1 <uartputc+0x41>
80105fda:	89 f2                	mov    %esi,%edx
80105fdc:	ec                   	in     (%dx),%al
80105fdd:	a8 20                	test   $0x20,%al
80105fdf:	74 e7                	je     80105fc8 <uartputc+0x28>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80105fe1:	8b 45 08             	mov    0x8(%ebp),%eax
80105fe4:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105fe9:	ee                   	out    %al,(%dx)
}
80105fea:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105fed:	5b                   	pop    %ebx
80105fee:	5e                   	pop    %esi
80105fef:	5d                   	pop    %ebp
80105ff0:	c3                   	ret
80105ff1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105ff8:	c3                   	ret
80105ff9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106000 <uartintr>:

void
uartintr(void)
{
80106000:	55                   	push   %ebp
80106001:	89 e5                	mov    %esp,%ebp
80106003:	83 ec 14             	sub    $0x14,%esp
  consoleintr(uartgetc);
80106006:	68 80 5e 10 80       	push   $0x80105e80
8010600b:	e8 90 a8 ff ff       	call   801008a0 <consoleintr>
}
80106010:	83 c4 10             	add    $0x10,%esp
80106013:	c9                   	leave
80106014:	c3                   	ret

80106015 <vector0>:
# generated by vectors.pl - do not edit
# handlers
.globl alltraps
.globl vector0
vector0:
  pushl $0
80106015:	6a 00                	push   $0x0
  pushl $0
80106017:	6a 00                	push   $0x0
  jmp alltraps
80106019:	e9 0c fb ff ff       	jmp    80105b2a <alltraps>

8010601e <vector1>:
.globl vector1
vector1:
  pushl $0
8010601e:	6a 00                	push   $0x0
  pushl $1
80106020:	6a 01                	push   $0x1
  jmp alltraps
80106022:	e9 03 fb ff ff       	jmp    80105b2a <alltraps>

80106027 <vector2>:
.globl vector2
vector2:
  pushl $0
80106027:	6a 00                	push   $0x0
  pushl $2
80106029:	6a 02                	push   $0x2
  jmp alltraps
8010602b:	e9 fa fa ff ff       	jmp    80105b2a <alltraps>

80106030 <vector3>:
.globl vector3
vector3:
  pushl $0
80106030:	6a 00                	push   $0x0
  pushl $3
80106032:	6a 03                	push   $0x3
  jmp alltraps
80106034:	e9 f1 fa ff ff       	jmp    80105b2a <alltraps>

80106039 <vector4>:
.globl vector4
vector4:
  pushl $0
80106039:	6a 00                	push   $0x0
  pushl $4
8010603b:	6a 04                	push   $0x4
  jmp alltraps
8010603d:	e9 e8 fa ff ff       	jmp    80105b2a <alltraps>

80106042 <vector5>:
.globl vector5
vector5:
  pushl $0
80106042:	6a 00                	push   $0x0
  pushl $5
80106044:	6a 05                	push   $0x5
  jmp alltraps
80106046:	e9 df fa ff ff       	jmp    80105b2a <alltraps>

8010604b <vector6>:
.globl vector6
vector6:
  pushl $0
8010604b:	6a 00                	push   $0x0
  pushl $6
8010604d:	6a 06                	push   $0x6
  jmp alltraps
8010604f:	e9 d6 fa ff ff       	jmp    80105b2a <alltraps>

80106054 <vector7>:
.globl vector7
vector7:
  pushl $0
80106054:	6a 00                	push   $0x0
  pushl $7
80106056:	6a 07                	push   $0x7
  jmp alltraps
80106058:	e9 cd fa ff ff       	jmp    80105b2a <alltraps>

8010605d <vector8>:
.globl vector8
vector8:
  pushl $8
8010605d:	6a 08                	push   $0x8
  jmp alltraps
8010605f:	e9 c6 fa ff ff       	jmp    80105b2a <alltraps>

80106064 <vector9>:
.globl vector9
vector9:
  pushl $0
80106064:	6a 00                	push   $0x0
  pushl $9
80106066:	6a 09                	push   $0x9
  jmp alltraps
80106068:	e9 bd fa ff ff       	jmp    80105b2a <alltraps>

8010606d <vector10>:
.globl vector10
vector10:
  pushl $10
8010606d:	6a 0a                	push   $0xa
  jmp alltraps
8010606f:	e9 b6 fa ff ff       	jmp    80105b2a <alltraps>

80106074 <vector11>:
.globl vector11
vector11:
  pushl $11
80106074:	6a 0b                	push   $0xb
  jmp alltraps
80106076:	e9 af fa ff ff       	jmp    80105b2a <alltraps>

8010607b <vector12>:
.globl vector12
vector12:
  pushl $12
8010607b:	6a 0c                	push   $0xc
  jmp alltraps
8010607d:	e9 a8 fa ff ff       	jmp    80105b2a <alltraps>

80106082 <vector13>:
.globl vector13
vector13:
  pushl $13
80106082:	6a 0d                	push   $0xd
  jmp alltraps
80106084:	e9 a1 fa ff ff       	jmp    80105b2a <alltraps>

80106089 <vector14>:
.globl vector14
vector14:
  pushl $14
80106089:	6a 0e                	push   $0xe
  jmp alltraps
8010608b:	e9 9a fa ff ff       	jmp    80105b2a <alltraps>

80106090 <vector15>:
.globl vector15
vector15:
  pushl $0
80106090:	6a 00                	push   $0x0
  pushl $15
80106092:	6a 0f                	push   $0xf
  jmp alltraps
80106094:	e9 91 fa ff ff       	jmp    80105b2a <alltraps>

80106099 <vector16>:
.globl vector16
vector16:
  pushl $0
80106099:	6a 00                	push   $0x0
  pushl $16
8010609b:	6a 10                	push   $0x10
  jmp alltraps
8010609d:	e9 88 fa ff ff       	jmp    80105b2a <alltraps>

801060a2 <vector17>:
.globl vector17
vector17:
  pushl $17
801060a2:	6a 11                	push   $0x11
  jmp alltraps
801060a4:	e9 81 fa ff ff       	jmp    80105b2a <alltraps>

801060a9 <vector18>:
.globl vector18
vector18:
  pushl $0
801060a9:	6a 00                	push   $0x0
  pushl $18
801060ab:	6a 12                	push   $0x12
  jmp alltraps
801060ad:	e9 78 fa ff ff       	jmp    80105b2a <alltraps>

801060b2 <vector19>:
.globl vector19
vector19:
  pushl $0
801060b2:	6a 00                	push   $0x0
  pushl $19
801060b4:	6a 13                	push   $0x13
  jmp alltraps
801060b6:	e9 6f fa ff ff       	jmp    80105b2a <alltraps>

801060bb <vector20>:
.globl vector20
vector20:
  pushl $0
801060bb:	6a 00                	push   $0x0
  pushl $20
801060bd:	6a 14                	push   $0x14
  jmp alltraps
801060bf:	e9 66 fa ff ff       	jmp    80105b2a <alltraps>

801060c4 <vector21>:
.globl vector21
vector21:
  pushl $0
801060c4:	6a 00                	push   $0x0
  pushl $21
801060c6:	6a 15                	push   $0x15
  jmp alltraps
801060c8:	e9 5d fa ff ff       	jmp    80105b2a <alltraps>

801060cd <vector22>:
.globl vector22
vector22:
  pushl $0
801060cd:	6a 00                	push   $0x0
  pushl $22
801060cf:	6a 16                	push   $0x16
  jmp alltraps
801060d1:	e9 54 fa ff ff       	jmp    80105b2a <alltraps>

801060d6 <vector23>:
.globl vector23
vector23:
  pushl $0
801060d6:	6a 00                	push   $0x0
  pushl $23
801060d8:	6a 17                	push   $0x17
  jmp alltraps
801060da:	e9 4b fa ff ff       	jmp    80105b2a <alltraps>

801060df <vector24>:
.globl vector24
vector24:
  pushl $0
801060df:	6a 00                	push   $0x0
  pushl $24
801060e1:	6a 18                	push   $0x18
  jmp alltraps
801060e3:	e9 42 fa ff ff       	jmp    80105b2a <alltraps>

801060e8 <vector25>:
.globl vector25
vector25:
  pushl $0
801060e8:	6a 00                	push   $0x0
  pushl $25
801060ea:	6a 19                	push   $0x19
  jmp alltraps
801060ec:	e9 39 fa ff ff       	jmp    80105b2a <alltraps>

801060f1 <vector26>:
.globl vector26
vector26:
  pushl $0
801060f1:	6a 00                	push   $0x0
  pushl $26
801060f3:	6a 1a                	push   $0x1a
  jmp alltraps
801060f5:	e9 30 fa ff ff       	jmp    80105b2a <alltraps>

801060fa <vector27>:
.globl vector27
vector27:
  pushl $0
801060fa:	6a 00                	push   $0x0
  pushl $27
801060fc:	6a 1b                	push   $0x1b
  jmp alltraps
801060fe:	e9 27 fa ff ff       	jmp    80105b2a <alltraps>

80106103 <vector28>:
.globl vector28
vector28:
  pushl $0
80106103:	6a 00                	push   $0x0
  pushl $28
80106105:	6a 1c                	push   $0x1c
  jmp alltraps
80106107:	e9 1e fa ff ff       	jmp    80105b2a <alltraps>

8010610c <vector29>:
.globl vector29
vector29:
  pushl $0
8010610c:	6a 00                	push   $0x0
  pushl $29
8010610e:	6a 1d                	push   $0x1d
  jmp alltraps
80106110:	e9 15 fa ff ff       	jmp    80105b2a <alltraps>

80106115 <vector30>:
.globl vector30
vector30:
  pushl $0
80106115:	6a 00                	push   $0x0
  pushl $30
80106117:	6a 1e                	push   $0x1e
  jmp alltraps
80106119:	e9 0c fa ff ff       	jmp    80105b2a <alltraps>

8010611e <vector31>:
.globl vector31
vector31:
  pushl $0
8010611e:	6a 00                	push   $0x0
  pushl $31
80106120:	6a 1f                	push   $0x1f
  jmp alltraps
80106122:	e9 03 fa ff ff       	jmp    80105b2a <alltraps>

80106127 <vector32>:
.globl vector32
vector32:
  pushl $0
80106127:	6a 00                	push   $0x0
  pushl $32
80106129:	6a 20                	push   $0x20
  jmp alltraps
8010612b:	e9 fa f9 ff ff       	jmp    80105b2a <alltraps>

80106130 <vector33>:
.globl vector33
vector33:
  pushl $0
80106130:	6a 00                	push   $0x0
  pushl $33
80106132:	6a 21                	push   $0x21
  jmp alltraps
80106134:	e9 f1 f9 ff ff       	jmp    80105b2a <alltraps>

80106139 <vector34>:
.globl vector34
vector34:
  pushl $0
80106139:	6a 00                	push   $0x0
  pushl $34
8010613b:	6a 22                	push   $0x22
  jmp alltraps
8010613d:	e9 e8 f9 ff ff       	jmp    80105b2a <alltraps>

80106142 <vector35>:
.globl vector35
vector35:
  pushl $0
80106142:	6a 00                	push   $0x0
  pushl $35
80106144:	6a 23                	push   $0x23
  jmp alltraps
80106146:	e9 df f9 ff ff       	jmp    80105b2a <alltraps>

8010614b <vector36>:
.globl vector36
vector36:
  pushl $0
8010614b:	6a 00                	push   $0x0
  pushl $36
8010614d:	6a 24                	push   $0x24
  jmp alltraps
8010614f:	e9 d6 f9 ff ff       	jmp    80105b2a <alltraps>

80106154 <vector37>:
.globl vector37
vector37:
  pushl $0
80106154:	6a 00                	push   $0x0
  pushl $37
80106156:	6a 25                	push   $0x25
  jmp alltraps
80106158:	e9 cd f9 ff ff       	jmp    80105b2a <alltraps>

8010615d <vector38>:
.globl vector38
vector38:
  pushl $0
8010615d:	6a 00                	push   $0x0
  pushl $38
8010615f:	6a 26                	push   $0x26
  jmp alltraps
80106161:	e9 c4 f9 ff ff       	jmp    80105b2a <alltraps>

80106166 <vector39>:
.globl vector39
vector39:
  pushl $0
80106166:	6a 00                	push   $0x0
  pushl $39
80106168:	6a 27                	push   $0x27
  jmp alltraps
8010616a:	e9 bb f9 ff ff       	jmp    80105b2a <alltraps>

8010616f <vector40>:
.globl vector40
vector40:
  pushl $0
8010616f:	6a 00                	push   $0x0
  pushl $40
80106171:	6a 28                	push   $0x28
  jmp alltraps
80106173:	e9 b2 f9 ff ff       	jmp    80105b2a <alltraps>

80106178 <vector41>:
.globl vector41
vector41:
  pushl $0
80106178:	6a 00                	push   $0x0
  pushl $41
8010617a:	6a 29                	push   $0x29
  jmp alltraps
8010617c:	e9 a9 f9 ff ff       	jmp    80105b2a <alltraps>

80106181 <vector42>:
.globl vector42
vector42:
  pushl $0
80106181:	6a 00                	push   $0x0
  pushl $42
80106183:	6a 2a                	push   $0x2a
  jmp alltraps
80106185:	e9 a0 f9 ff ff       	jmp    80105b2a <alltraps>

8010618a <vector43>:
.globl vector43
vector43:
  pushl $0
8010618a:	6a 00                	push   $0x0
  pushl $43
8010618c:	6a 2b                	push   $0x2b
  jmp alltraps
8010618e:	e9 97 f9 ff ff       	jmp    80105b2a <alltraps>

80106193 <vector44>:
.globl vector44
vector44:
  pushl $0
80106193:	6a 00                	push   $0x0
  pushl $44
80106195:	6a 2c                	push   $0x2c
  jmp alltraps
80106197:	e9 8e f9 ff ff       	jmp    80105b2a <alltraps>

8010619c <vector45>:
.globl vector45
vector45:
  pushl $0
8010619c:	6a 00                	push   $0x0
  pushl $45
8010619e:	6a 2d                	push   $0x2d
  jmp alltraps
801061a0:	e9 85 f9 ff ff       	jmp    80105b2a <alltraps>

801061a5 <vector46>:
.globl vector46
vector46:
  pushl $0
801061a5:	6a 00                	push   $0x0
  pushl $46
801061a7:	6a 2e                	push   $0x2e
  jmp alltraps
801061a9:	e9 7c f9 ff ff       	jmp    80105b2a <alltraps>

801061ae <vector47>:
.globl vector47
vector47:
  pushl $0
801061ae:	6a 00                	push   $0x0
  pushl $47
801061b0:	6a 2f                	push   $0x2f
  jmp alltraps
801061b2:	e9 73 f9 ff ff       	jmp    80105b2a <alltraps>

801061b7 <vector48>:
.globl vector48
vector48:
  pushl $0
801061b7:	6a 00                	push   $0x0
  pushl $48
801061b9:	6a 30                	push   $0x30
  jmp alltraps
801061bb:	e9 6a f9 ff ff       	jmp    80105b2a <alltraps>

801061c0 <vector49>:
.globl vector49
vector49:
  pushl $0
801061c0:	6a 00                	push   $0x0
  pushl $49
801061c2:	6a 31                	push   $0x31
  jmp alltraps
801061c4:	e9 61 f9 ff ff       	jmp    80105b2a <alltraps>

801061c9 <vector50>:
.globl vector50
vector50:
  pushl $0
801061c9:	6a 00                	push   $0x0
  pushl $50
801061cb:	6a 32                	push   $0x32
  jmp alltraps
801061cd:	e9 58 f9 ff ff       	jmp    80105b2a <alltraps>

801061d2 <vector51>:
.globl vector51
vector51:
  pushl $0
801061d2:	6a 00                	push   $0x0
  pushl $51
801061d4:	6a 33                	push   $0x33
  jmp alltraps
801061d6:	e9 4f f9 ff ff       	jmp    80105b2a <alltraps>

801061db <vector52>:
.globl vector52
vector52:
  pushl $0
801061db:	6a 00                	push   $0x0
  pushl $52
801061dd:	6a 34                	push   $0x34
  jmp alltraps
801061df:	e9 46 f9 ff ff       	jmp    80105b2a <alltraps>

801061e4 <vector53>:
.globl vector53
vector53:
  pushl $0
801061e4:	6a 00                	push   $0x0
  pushl $53
801061e6:	6a 35                	push   $0x35
  jmp alltraps
801061e8:	e9 3d f9 ff ff       	jmp    80105b2a <alltraps>

801061ed <vector54>:
.globl vector54
vector54:
  pushl $0
801061ed:	6a 00                	push   $0x0
  pushl $54
801061ef:	6a 36                	push   $0x36
  jmp alltraps
801061f1:	e9 34 f9 ff ff       	jmp    80105b2a <alltraps>

801061f6 <vector55>:
.globl vector55
vector55:
  pushl $0
801061f6:	6a 00                	push   $0x0
  pushl $55
801061f8:	6a 37                	push   $0x37
  jmp alltraps
801061fa:	e9 2b f9 ff ff       	jmp    80105b2a <alltraps>

801061ff <vector56>:
.globl vector56
vector56:
  pushl $0
801061ff:	6a 00                	push   $0x0
  pushl $56
80106201:	6a 38                	push   $0x38
  jmp alltraps
80106203:	e9 22 f9 ff ff       	jmp    80105b2a <alltraps>

80106208 <vector57>:
.globl vector57
vector57:
  pushl $0
80106208:	6a 00                	push   $0x0
  pushl $57
8010620a:	6a 39                	push   $0x39
  jmp alltraps
8010620c:	e9 19 f9 ff ff       	jmp    80105b2a <alltraps>

80106211 <vector58>:
.globl vector58
vector58:
  pushl $0
80106211:	6a 00                	push   $0x0
  pushl $58
80106213:	6a 3a                	push   $0x3a
  jmp alltraps
80106215:	e9 10 f9 ff ff       	jmp    80105b2a <alltraps>

8010621a <vector59>:
.globl vector59
vector59:
  pushl $0
8010621a:	6a 00                	push   $0x0
  pushl $59
8010621c:	6a 3b                	push   $0x3b
  jmp alltraps
8010621e:	e9 07 f9 ff ff       	jmp    80105b2a <alltraps>

80106223 <vector60>:
.globl vector60
vector60:
  pushl $0
80106223:	6a 00                	push   $0x0
  pushl $60
80106225:	6a 3c                	push   $0x3c
  jmp alltraps
80106227:	e9 fe f8 ff ff       	jmp    80105b2a <alltraps>

8010622c <vector61>:
.globl vector61
vector61:
  pushl $0
8010622c:	6a 00                	push   $0x0
  pushl $61
8010622e:	6a 3d                	push   $0x3d
  jmp alltraps
80106230:	e9 f5 f8 ff ff       	jmp    80105b2a <alltraps>

80106235 <vector62>:
.globl vector62
vector62:
  pushl $0
80106235:	6a 00                	push   $0x0
  pushl $62
80106237:	6a 3e                	push   $0x3e
  jmp alltraps
80106239:	e9 ec f8 ff ff       	jmp    80105b2a <alltraps>

8010623e <vector63>:
.globl vector63
vector63:
  pushl $0
8010623e:	6a 00                	push   $0x0
  pushl $63
80106240:	6a 3f                	push   $0x3f
  jmp alltraps
80106242:	e9 e3 f8 ff ff       	jmp    80105b2a <alltraps>

80106247 <vector64>:
.globl vector64
vector64:
  pushl $0
80106247:	6a 00                	push   $0x0
  pushl $64
80106249:	6a 40                	push   $0x40
  jmp alltraps
8010624b:	e9 da f8 ff ff       	jmp    80105b2a <alltraps>

80106250 <vector65>:
.globl vector65
vector65:
  pushl $0
80106250:	6a 00                	push   $0x0
  pushl $65
80106252:	6a 41                	push   $0x41
  jmp alltraps
80106254:	e9 d1 f8 ff ff       	jmp    80105b2a <alltraps>

80106259 <vector66>:
.globl vector66
vector66:
  pushl $0
80106259:	6a 00                	push   $0x0
  pushl $66
8010625b:	6a 42                	push   $0x42
  jmp alltraps
8010625d:	e9 c8 f8 ff ff       	jmp    80105b2a <alltraps>

80106262 <vector67>:
.globl vector67
vector67:
  pushl $0
80106262:	6a 00                	push   $0x0
  pushl $67
80106264:	6a 43                	push   $0x43
  jmp alltraps
80106266:	e9 bf f8 ff ff       	jmp    80105b2a <alltraps>

8010626b <vector68>:
.globl vector68
vector68:
  pushl $0
8010626b:	6a 00                	push   $0x0
  pushl $68
8010626d:	6a 44                	push   $0x44
  jmp alltraps
8010626f:	e9 b6 f8 ff ff       	jmp    80105b2a <alltraps>

80106274 <vector69>:
.globl vector69
vector69:
  pushl $0
80106274:	6a 00                	push   $0x0
  pushl $69
80106276:	6a 45                	push   $0x45
  jmp alltraps
80106278:	e9 ad f8 ff ff       	jmp    80105b2a <alltraps>

8010627d <vector70>:
.globl vector70
vector70:
  pushl $0
8010627d:	6a 00                	push   $0x0
  pushl $70
8010627f:	6a 46                	push   $0x46
  jmp alltraps
80106281:	e9 a4 f8 ff ff       	jmp    80105b2a <alltraps>

80106286 <vector71>:
.globl vector71
vector71:
  pushl $0
80106286:	6a 00                	push   $0x0
  pushl $71
80106288:	6a 47                	push   $0x47
  jmp alltraps
8010628a:	e9 9b f8 ff ff       	jmp    80105b2a <alltraps>

8010628f <vector72>:
.globl vector72
vector72:
  pushl $0
8010628f:	6a 00                	push   $0x0
  pushl $72
80106291:	6a 48                	push   $0x48
  jmp alltraps
80106293:	e9 92 f8 ff ff       	jmp    80105b2a <alltraps>

80106298 <vector73>:
.globl vector73
vector73:
  pushl $0
80106298:	6a 00                	push   $0x0
  pushl $73
8010629a:	6a 49                	push   $0x49
  jmp alltraps
8010629c:	e9 89 f8 ff ff       	jmp    80105b2a <alltraps>

801062a1 <vector74>:
.globl vector74
vector74:
  pushl $0
801062a1:	6a 00                	push   $0x0
  pushl $74
801062a3:	6a 4a                	push   $0x4a
  jmp alltraps
801062a5:	e9 80 f8 ff ff       	jmp    80105b2a <alltraps>

801062aa <vector75>:
.globl vector75
vector75:
  pushl $0
801062aa:	6a 00                	push   $0x0
  pushl $75
801062ac:	6a 4b                	push   $0x4b
  jmp alltraps
801062ae:	e9 77 f8 ff ff       	jmp    80105b2a <alltraps>

801062b3 <vector76>:
.globl vector76
vector76:
  pushl $0
801062b3:	6a 00                	push   $0x0
  pushl $76
801062b5:	6a 4c                	push   $0x4c
  jmp alltraps
801062b7:	e9 6e f8 ff ff       	jmp    80105b2a <alltraps>

801062bc <vector77>:
.globl vector77
vector77:
  pushl $0
801062bc:	6a 00                	push   $0x0
  pushl $77
801062be:	6a 4d                	push   $0x4d
  jmp alltraps
801062c0:	e9 65 f8 ff ff       	jmp    80105b2a <alltraps>

801062c5 <vector78>:
.globl vector78
vector78:
  pushl $0
801062c5:	6a 00                	push   $0x0
  pushl $78
801062c7:	6a 4e                	push   $0x4e
  jmp alltraps
801062c9:	e9 5c f8 ff ff       	jmp    80105b2a <alltraps>

801062ce <vector79>:
.globl vector79
vector79:
  pushl $0
801062ce:	6a 00                	push   $0x0
  pushl $79
801062d0:	6a 4f                	push   $0x4f
  jmp alltraps
801062d2:	e9 53 f8 ff ff       	jmp    80105b2a <alltraps>

801062d7 <vector80>:
.globl vector80
vector80:
  pushl $0
801062d7:	6a 00                	push   $0x0
  pushl $80
801062d9:	6a 50                	push   $0x50
  jmp alltraps
801062db:	e9 4a f8 ff ff       	jmp    80105b2a <alltraps>

801062e0 <vector81>:
.globl vector81
vector81:
  pushl $0
801062e0:	6a 00                	push   $0x0
  pushl $81
801062e2:	6a 51                	push   $0x51
  jmp alltraps
801062e4:	e9 41 f8 ff ff       	jmp    80105b2a <alltraps>

801062e9 <vector82>:
.globl vector82
vector82:
  pushl $0
801062e9:	6a 00                	push   $0x0
  pushl $82
801062eb:	6a 52                	push   $0x52
  jmp alltraps
801062ed:	e9 38 f8 ff ff       	jmp    80105b2a <alltraps>

801062f2 <vector83>:
.globl vector83
vector83:
  pushl $0
801062f2:	6a 00                	push   $0x0
  pushl $83
801062f4:	6a 53                	push   $0x53
  jmp alltraps
801062f6:	e9 2f f8 ff ff       	jmp    80105b2a <alltraps>

801062fb <vector84>:
.globl vector84
vector84:
  pushl $0
801062fb:	6a 00                	push   $0x0
  pushl $84
801062fd:	6a 54                	push   $0x54
  jmp alltraps
801062ff:	e9 26 f8 ff ff       	jmp    80105b2a <alltraps>

80106304 <vector85>:
.globl vector85
vector85:
  pushl $0
80106304:	6a 00                	push   $0x0
  pushl $85
80106306:	6a 55                	push   $0x55
  jmp alltraps
80106308:	e9 1d f8 ff ff       	jmp    80105b2a <alltraps>

8010630d <vector86>:
.globl vector86
vector86:
  pushl $0
8010630d:	6a 00                	push   $0x0
  pushl $86
8010630f:	6a 56                	push   $0x56
  jmp alltraps
80106311:	e9 14 f8 ff ff       	jmp    80105b2a <alltraps>

80106316 <vector87>:
.globl vector87
vector87:
  pushl $0
80106316:	6a 00                	push   $0x0
  pushl $87
80106318:	6a 57                	push   $0x57
  jmp alltraps
8010631a:	e9 0b f8 ff ff       	jmp    80105b2a <alltraps>

8010631f <vector88>:
.globl vector88
vector88:
  pushl $0
8010631f:	6a 00                	push   $0x0
  pushl $88
80106321:	6a 58                	push   $0x58
  jmp alltraps
80106323:	e9 02 f8 ff ff       	jmp    80105b2a <alltraps>

80106328 <vector89>:
.globl vector89
vector89:
  pushl $0
80106328:	6a 00                	push   $0x0
  pushl $89
8010632a:	6a 59                	push   $0x59
  jmp alltraps
8010632c:	e9 f9 f7 ff ff       	jmp    80105b2a <alltraps>

80106331 <vector90>:
.globl vector90
vector90:
  pushl $0
80106331:	6a 00                	push   $0x0
  pushl $90
80106333:	6a 5a                	push   $0x5a
  jmp alltraps
80106335:	e9 f0 f7 ff ff       	jmp    80105b2a <alltraps>

8010633a <vector91>:
.globl vector91
vector91:
  pushl $0
8010633a:	6a 00                	push   $0x0
  pushl $91
8010633c:	6a 5b                	push   $0x5b
  jmp alltraps
8010633e:	e9 e7 f7 ff ff       	jmp    80105b2a <alltraps>

80106343 <vector92>:
.globl vector92
vector92:
  pushl $0
80106343:	6a 00                	push   $0x0
  pushl $92
80106345:	6a 5c                	push   $0x5c
  jmp alltraps
80106347:	e9 de f7 ff ff       	jmp    80105b2a <alltraps>

8010634c <vector93>:
.globl vector93
vector93:
  pushl $0
8010634c:	6a 00                	push   $0x0
  pushl $93
8010634e:	6a 5d                	push   $0x5d
  jmp alltraps
80106350:	e9 d5 f7 ff ff       	jmp    80105b2a <alltraps>

80106355 <vector94>:
.globl vector94
vector94:
  pushl $0
80106355:	6a 00                	push   $0x0
  pushl $94
80106357:	6a 5e                	push   $0x5e
  jmp alltraps
80106359:	e9 cc f7 ff ff       	jmp    80105b2a <alltraps>

8010635e <vector95>:
.globl vector95
vector95:
  pushl $0
8010635e:	6a 00                	push   $0x0
  pushl $95
80106360:	6a 5f                	push   $0x5f
  jmp alltraps
80106362:	e9 c3 f7 ff ff       	jmp    80105b2a <alltraps>

80106367 <vector96>:
.globl vector96
vector96:
  pushl $0
80106367:	6a 00                	push   $0x0
  pushl $96
80106369:	6a 60                	push   $0x60
  jmp alltraps
8010636b:	e9 ba f7 ff ff       	jmp    80105b2a <alltraps>

80106370 <vector97>:
.globl vector97
vector97:
  pushl $0
80106370:	6a 00                	push   $0x0
  pushl $97
80106372:	6a 61                	push   $0x61
  jmp alltraps
80106374:	e9 b1 f7 ff ff       	jmp    80105b2a <alltraps>

80106379 <vector98>:
.globl vector98
vector98:
  pushl $0
80106379:	6a 00                	push   $0x0
  pushl $98
8010637b:	6a 62                	push   $0x62
  jmp alltraps
8010637d:	e9 a8 f7 ff ff       	jmp    80105b2a <alltraps>

80106382 <vector99>:
.globl vector99
vector99:
  pushl $0
80106382:	6a 00                	push   $0x0
  pushl $99
80106384:	6a 63                	push   $0x63
  jmp alltraps
80106386:	e9 9f f7 ff ff       	jmp    80105b2a <alltraps>

8010638b <vector100>:
.globl vector100
vector100:
  pushl $0
8010638b:	6a 00                	push   $0x0
  pushl $100
8010638d:	6a 64                	push   $0x64
  jmp alltraps
8010638f:	e9 96 f7 ff ff       	jmp    80105b2a <alltraps>

80106394 <vector101>:
.globl vector101
vector101:
  pushl $0
80106394:	6a 00                	push   $0x0
  pushl $101
80106396:	6a 65                	push   $0x65
  jmp alltraps
80106398:	e9 8d f7 ff ff       	jmp    80105b2a <alltraps>

8010639d <vector102>:
.globl vector102
vector102:
  pushl $0
8010639d:	6a 00                	push   $0x0
  pushl $102
8010639f:	6a 66                	push   $0x66
  jmp alltraps
801063a1:	e9 84 f7 ff ff       	jmp    80105b2a <alltraps>

801063a6 <vector103>:
.globl vector103
vector103:
  pushl $0
801063a6:	6a 00                	push   $0x0
  pushl $103
801063a8:	6a 67                	push   $0x67
  jmp alltraps
801063aa:	e9 7b f7 ff ff       	jmp    80105b2a <alltraps>

801063af <vector104>:
.globl vector104
vector104:
  pushl $0
801063af:	6a 00                	push   $0x0
  pushl $104
801063b1:	6a 68                	push   $0x68
  jmp alltraps
801063b3:	e9 72 f7 ff ff       	jmp    80105b2a <alltraps>

801063b8 <vector105>:
.globl vector105
vector105:
  pushl $0
801063b8:	6a 00                	push   $0x0
  pushl $105
801063ba:	6a 69                	push   $0x69
  jmp alltraps
801063bc:	e9 69 f7 ff ff       	jmp    80105b2a <alltraps>

801063c1 <vector106>:
.globl vector106
vector106:
  pushl $0
801063c1:	6a 00                	push   $0x0
  pushl $106
801063c3:	6a 6a                	push   $0x6a
  jmp alltraps
801063c5:	e9 60 f7 ff ff       	jmp    80105b2a <alltraps>

801063ca <vector107>:
.globl vector107
vector107:
  pushl $0
801063ca:	6a 00                	push   $0x0
  pushl $107
801063cc:	6a 6b                	push   $0x6b
  jmp alltraps
801063ce:	e9 57 f7 ff ff       	jmp    80105b2a <alltraps>

801063d3 <vector108>:
.globl vector108
vector108:
  pushl $0
801063d3:	6a 00                	push   $0x0
  pushl $108
801063d5:	6a 6c                	push   $0x6c
  jmp alltraps
801063d7:	e9 4e f7 ff ff       	jmp    80105b2a <alltraps>

801063dc <vector109>:
.globl vector109
vector109:
  pushl $0
801063dc:	6a 00                	push   $0x0
  pushl $109
801063de:	6a 6d                	push   $0x6d
  jmp alltraps
801063e0:	e9 45 f7 ff ff       	jmp    80105b2a <alltraps>

801063e5 <vector110>:
.globl vector110
vector110:
  pushl $0
801063e5:	6a 00                	push   $0x0
  pushl $110
801063e7:	6a 6e                	push   $0x6e
  jmp alltraps
801063e9:	e9 3c f7 ff ff       	jmp    80105b2a <alltraps>

801063ee <vector111>:
.globl vector111
vector111:
  pushl $0
801063ee:	6a 00                	push   $0x0
  pushl $111
801063f0:	6a 6f                	push   $0x6f
  jmp alltraps
801063f2:	e9 33 f7 ff ff       	jmp    80105b2a <alltraps>

801063f7 <vector112>:
.globl vector112
vector112:
  pushl $0
801063f7:	6a 00                	push   $0x0
  pushl $112
801063f9:	6a 70                	push   $0x70
  jmp alltraps
801063fb:	e9 2a f7 ff ff       	jmp    80105b2a <alltraps>

80106400 <vector113>:
.globl vector113
vector113:
  pushl $0
80106400:	6a 00                	push   $0x0
  pushl $113
80106402:	6a 71                	push   $0x71
  jmp alltraps
80106404:	e9 21 f7 ff ff       	jmp    80105b2a <alltraps>

80106409 <vector114>:
.globl vector114
vector114:
  pushl $0
80106409:	6a 00                	push   $0x0
  pushl $114
8010640b:	6a 72                	push   $0x72
  jmp alltraps
8010640d:	e9 18 f7 ff ff       	jmp    80105b2a <alltraps>

80106412 <vector115>:
.globl vector115
vector115:
  pushl $0
80106412:	6a 00                	push   $0x0
  pushl $115
80106414:	6a 73                	push   $0x73
  jmp alltraps
80106416:	e9 0f f7 ff ff       	jmp    80105b2a <alltraps>

8010641b <vector116>:
.globl vector116
vector116:
  pushl $0
8010641b:	6a 00                	push   $0x0
  pushl $116
8010641d:	6a 74                	push   $0x74
  jmp alltraps
8010641f:	e9 06 f7 ff ff       	jmp    80105b2a <alltraps>

80106424 <vector117>:
.globl vector117
vector117:
  pushl $0
80106424:	6a 00                	push   $0x0
  pushl $117
80106426:	6a 75                	push   $0x75
  jmp alltraps
80106428:	e9 fd f6 ff ff       	jmp    80105b2a <alltraps>

8010642d <vector118>:
.globl vector118
vector118:
  pushl $0
8010642d:	6a 00                	push   $0x0
  pushl $118
8010642f:	6a 76                	push   $0x76
  jmp alltraps
80106431:	e9 f4 f6 ff ff       	jmp    80105b2a <alltraps>

80106436 <vector119>:
.globl vector119
vector119:
  pushl $0
80106436:	6a 00                	push   $0x0
  pushl $119
80106438:	6a 77                	push   $0x77
  jmp alltraps
8010643a:	e9 eb f6 ff ff       	jmp    80105b2a <alltraps>

8010643f <vector120>:
.globl vector120
vector120:
  pushl $0
8010643f:	6a 00                	push   $0x0
  pushl $120
80106441:	6a 78                	push   $0x78
  jmp alltraps
80106443:	e9 e2 f6 ff ff       	jmp    80105b2a <alltraps>

80106448 <vector121>:
.globl vector121
vector121:
  pushl $0
80106448:	6a 00                	push   $0x0
  pushl $121
8010644a:	6a 79                	push   $0x79
  jmp alltraps
8010644c:	e9 d9 f6 ff ff       	jmp    80105b2a <alltraps>

80106451 <vector122>:
.globl vector122
vector122:
  pushl $0
80106451:	6a 00                	push   $0x0
  pushl $122
80106453:	6a 7a                	push   $0x7a
  jmp alltraps
80106455:	e9 d0 f6 ff ff       	jmp    80105b2a <alltraps>

8010645a <vector123>:
.globl vector123
vector123:
  pushl $0
8010645a:	6a 00                	push   $0x0
  pushl $123
8010645c:	6a 7b                	push   $0x7b
  jmp alltraps
8010645e:	e9 c7 f6 ff ff       	jmp    80105b2a <alltraps>

80106463 <vector124>:
.globl vector124
vector124:
  pushl $0
80106463:	6a 00                	push   $0x0
  pushl $124
80106465:	6a 7c                	push   $0x7c
  jmp alltraps
80106467:	e9 be f6 ff ff       	jmp    80105b2a <alltraps>

8010646c <vector125>:
.globl vector125
vector125:
  pushl $0
8010646c:	6a 00                	push   $0x0
  pushl $125
8010646e:	6a 7d                	push   $0x7d
  jmp alltraps
80106470:	e9 b5 f6 ff ff       	jmp    80105b2a <alltraps>

80106475 <vector126>:
.globl vector126
vector126:
  pushl $0
80106475:	6a 00                	push   $0x0
  pushl $126
80106477:	6a 7e                	push   $0x7e
  jmp alltraps
80106479:	e9 ac f6 ff ff       	jmp    80105b2a <alltraps>

8010647e <vector127>:
.globl vector127
vector127:
  pushl $0
8010647e:	6a 00                	push   $0x0
  pushl $127
80106480:	6a 7f                	push   $0x7f
  jmp alltraps
80106482:	e9 a3 f6 ff ff       	jmp    80105b2a <alltraps>

80106487 <vector128>:
.globl vector128
vector128:
  pushl $0
80106487:	6a 00                	push   $0x0
  pushl $128
80106489:	68 80 00 00 00       	push   $0x80
  jmp alltraps
8010648e:	e9 97 f6 ff ff       	jmp    80105b2a <alltraps>

80106493 <vector129>:
.globl vector129
vector129:
  pushl $0
80106493:	6a 00                	push   $0x0
  pushl $129
80106495:	68 81 00 00 00       	push   $0x81
  jmp alltraps
8010649a:	e9 8b f6 ff ff       	jmp    80105b2a <alltraps>

8010649f <vector130>:
.globl vector130
vector130:
  pushl $0
8010649f:	6a 00                	push   $0x0
  pushl $130
801064a1:	68 82 00 00 00       	push   $0x82
  jmp alltraps
801064a6:	e9 7f f6 ff ff       	jmp    80105b2a <alltraps>

801064ab <vector131>:
.globl vector131
vector131:
  pushl $0
801064ab:	6a 00                	push   $0x0
  pushl $131
801064ad:	68 83 00 00 00       	push   $0x83
  jmp alltraps
801064b2:	e9 73 f6 ff ff       	jmp    80105b2a <alltraps>

801064b7 <vector132>:
.globl vector132
vector132:
  pushl $0
801064b7:	6a 00                	push   $0x0
  pushl $132
801064b9:	68 84 00 00 00       	push   $0x84
  jmp alltraps
801064be:	e9 67 f6 ff ff       	jmp    80105b2a <alltraps>

801064c3 <vector133>:
.globl vector133
vector133:
  pushl $0
801064c3:	6a 00                	push   $0x0
  pushl $133
801064c5:	68 85 00 00 00       	push   $0x85
  jmp alltraps
801064ca:	e9 5b f6 ff ff       	jmp    80105b2a <alltraps>

801064cf <vector134>:
.globl vector134
vector134:
  pushl $0
801064cf:	6a 00                	push   $0x0
  pushl $134
801064d1:	68 86 00 00 00       	push   $0x86
  jmp alltraps
801064d6:	e9 4f f6 ff ff       	jmp    80105b2a <alltraps>

801064db <vector135>:
.globl vector135
vector135:
  pushl $0
801064db:	6a 00                	push   $0x0
  pushl $135
801064dd:	68 87 00 00 00       	push   $0x87
  jmp alltraps
801064e2:	e9 43 f6 ff ff       	jmp    80105b2a <alltraps>

801064e7 <vector136>:
.globl vector136
vector136:
  pushl $0
801064e7:	6a 00                	push   $0x0
  pushl $136
801064e9:	68 88 00 00 00       	push   $0x88
  jmp alltraps
801064ee:	e9 37 f6 ff ff       	jmp    80105b2a <alltraps>

801064f3 <vector137>:
.globl vector137
vector137:
  pushl $0
801064f3:	6a 00                	push   $0x0
  pushl $137
801064f5:	68 89 00 00 00       	push   $0x89
  jmp alltraps
801064fa:	e9 2b f6 ff ff       	jmp    80105b2a <alltraps>

801064ff <vector138>:
.globl vector138
vector138:
  pushl $0
801064ff:	6a 00                	push   $0x0
  pushl $138
80106501:	68 8a 00 00 00       	push   $0x8a
  jmp alltraps
80106506:	e9 1f f6 ff ff       	jmp    80105b2a <alltraps>

8010650b <vector139>:
.globl vector139
vector139:
  pushl $0
8010650b:	6a 00                	push   $0x0
  pushl $139
8010650d:	68 8b 00 00 00       	push   $0x8b
  jmp alltraps
80106512:	e9 13 f6 ff ff       	jmp    80105b2a <alltraps>

80106517 <vector140>:
.globl vector140
vector140:
  pushl $0
80106517:	6a 00                	push   $0x0
  pushl $140
80106519:	68 8c 00 00 00       	push   $0x8c
  jmp alltraps
8010651e:	e9 07 f6 ff ff       	jmp    80105b2a <alltraps>

80106523 <vector141>:
.globl vector141
vector141:
  pushl $0
80106523:	6a 00                	push   $0x0
  pushl $141
80106525:	68 8d 00 00 00       	push   $0x8d
  jmp alltraps
8010652a:	e9 fb f5 ff ff       	jmp    80105b2a <alltraps>

8010652f <vector142>:
.globl vector142
vector142:
  pushl $0
8010652f:	6a 00                	push   $0x0
  pushl $142
80106531:	68 8e 00 00 00       	push   $0x8e
  jmp alltraps
80106536:	e9 ef f5 ff ff       	jmp    80105b2a <alltraps>

8010653b <vector143>:
.globl vector143
vector143:
  pushl $0
8010653b:	6a 00                	push   $0x0
  pushl $143
8010653d:	68 8f 00 00 00       	push   $0x8f
  jmp alltraps
80106542:	e9 e3 f5 ff ff       	jmp    80105b2a <alltraps>

80106547 <vector144>:
.globl vector144
vector144:
  pushl $0
80106547:	6a 00                	push   $0x0
  pushl $144
80106549:	68 90 00 00 00       	push   $0x90
  jmp alltraps
8010654e:	e9 d7 f5 ff ff       	jmp    80105b2a <alltraps>

80106553 <vector145>:
.globl vector145
vector145:
  pushl $0
80106553:	6a 00                	push   $0x0
  pushl $145
80106555:	68 91 00 00 00       	push   $0x91
  jmp alltraps
8010655a:	e9 cb f5 ff ff       	jmp    80105b2a <alltraps>

8010655f <vector146>:
.globl vector146
vector146:
  pushl $0
8010655f:	6a 00                	push   $0x0
  pushl $146
80106561:	68 92 00 00 00       	push   $0x92
  jmp alltraps
80106566:	e9 bf f5 ff ff       	jmp    80105b2a <alltraps>

8010656b <vector147>:
.globl vector147
vector147:
  pushl $0
8010656b:	6a 00                	push   $0x0
  pushl $147
8010656d:	68 93 00 00 00       	push   $0x93
  jmp alltraps
80106572:	e9 b3 f5 ff ff       	jmp    80105b2a <alltraps>

80106577 <vector148>:
.globl vector148
vector148:
  pushl $0
80106577:	6a 00                	push   $0x0
  pushl $148
80106579:	68 94 00 00 00       	push   $0x94
  jmp alltraps
8010657e:	e9 a7 f5 ff ff       	jmp    80105b2a <alltraps>

80106583 <vector149>:
.globl vector149
vector149:
  pushl $0
80106583:	6a 00                	push   $0x0
  pushl $149
80106585:	68 95 00 00 00       	push   $0x95
  jmp alltraps
8010658a:	e9 9b f5 ff ff       	jmp    80105b2a <alltraps>

8010658f <vector150>:
.globl vector150
vector150:
  pushl $0
8010658f:	6a 00                	push   $0x0
  pushl $150
80106591:	68 96 00 00 00       	push   $0x96
  jmp alltraps
80106596:	e9 8f f5 ff ff       	jmp    80105b2a <alltraps>

8010659b <vector151>:
.globl vector151
vector151:
  pushl $0
8010659b:	6a 00                	push   $0x0
  pushl $151
8010659d:	68 97 00 00 00       	push   $0x97
  jmp alltraps
801065a2:	e9 83 f5 ff ff       	jmp    80105b2a <alltraps>

801065a7 <vector152>:
.globl vector152
vector152:
  pushl $0
801065a7:	6a 00                	push   $0x0
  pushl $152
801065a9:	68 98 00 00 00       	push   $0x98
  jmp alltraps
801065ae:	e9 77 f5 ff ff       	jmp    80105b2a <alltraps>

801065b3 <vector153>:
.globl vector153
vector153:
  pushl $0
801065b3:	6a 00                	push   $0x0
  pushl $153
801065b5:	68 99 00 00 00       	push   $0x99
  jmp alltraps
801065ba:	e9 6b f5 ff ff       	jmp    80105b2a <alltraps>

801065bf <vector154>:
.globl vector154
vector154:
  pushl $0
801065bf:	6a 00                	push   $0x0
  pushl $154
801065c1:	68 9a 00 00 00       	push   $0x9a
  jmp alltraps
801065c6:	e9 5f f5 ff ff       	jmp    80105b2a <alltraps>

801065cb <vector155>:
.globl vector155
vector155:
  pushl $0
801065cb:	6a 00                	push   $0x0
  pushl $155
801065cd:	68 9b 00 00 00       	push   $0x9b
  jmp alltraps
801065d2:	e9 53 f5 ff ff       	jmp    80105b2a <alltraps>

801065d7 <vector156>:
.globl vector156
vector156:
  pushl $0
801065d7:	6a 00                	push   $0x0
  pushl $156
801065d9:	68 9c 00 00 00       	push   $0x9c
  jmp alltraps
801065de:	e9 47 f5 ff ff       	jmp    80105b2a <alltraps>

801065e3 <vector157>:
.globl vector157
vector157:
  pushl $0
801065e3:	6a 00                	push   $0x0
  pushl $157
801065e5:	68 9d 00 00 00       	push   $0x9d
  jmp alltraps
801065ea:	e9 3b f5 ff ff       	jmp    80105b2a <alltraps>

801065ef <vector158>:
.globl vector158
vector158:
  pushl $0
801065ef:	6a 00                	push   $0x0
  pushl $158
801065f1:	68 9e 00 00 00       	push   $0x9e
  jmp alltraps
801065f6:	e9 2f f5 ff ff       	jmp    80105b2a <alltraps>

801065fb <vector159>:
.globl vector159
vector159:
  pushl $0
801065fb:	6a 00                	push   $0x0
  pushl $159
801065fd:	68 9f 00 00 00       	push   $0x9f
  jmp alltraps
80106602:	e9 23 f5 ff ff       	jmp    80105b2a <alltraps>

80106607 <vector160>:
.globl vector160
vector160:
  pushl $0
80106607:	6a 00                	push   $0x0
  pushl $160
80106609:	68 a0 00 00 00       	push   $0xa0
  jmp alltraps
8010660e:	e9 17 f5 ff ff       	jmp    80105b2a <alltraps>

80106613 <vector161>:
.globl vector161
vector161:
  pushl $0
80106613:	6a 00                	push   $0x0
  pushl $161
80106615:	68 a1 00 00 00       	push   $0xa1
  jmp alltraps
8010661a:	e9 0b f5 ff ff       	jmp    80105b2a <alltraps>

8010661f <vector162>:
.globl vector162
vector162:
  pushl $0
8010661f:	6a 00                	push   $0x0
  pushl $162
80106621:	68 a2 00 00 00       	push   $0xa2
  jmp alltraps
80106626:	e9 ff f4 ff ff       	jmp    80105b2a <alltraps>

8010662b <vector163>:
.globl vector163
vector163:
  pushl $0
8010662b:	6a 00                	push   $0x0
  pushl $163
8010662d:	68 a3 00 00 00       	push   $0xa3
  jmp alltraps
80106632:	e9 f3 f4 ff ff       	jmp    80105b2a <alltraps>

80106637 <vector164>:
.globl vector164
vector164:
  pushl $0
80106637:	6a 00                	push   $0x0
  pushl $164
80106639:	68 a4 00 00 00       	push   $0xa4
  jmp alltraps
8010663e:	e9 e7 f4 ff ff       	jmp    80105b2a <alltraps>

80106643 <vector165>:
.globl vector165
vector165:
  pushl $0
80106643:	6a 00                	push   $0x0
  pushl $165
80106645:	68 a5 00 00 00       	push   $0xa5
  jmp alltraps
8010664a:	e9 db f4 ff ff       	jmp    80105b2a <alltraps>

8010664f <vector166>:
.globl vector166
vector166:
  pushl $0
8010664f:	6a 00                	push   $0x0
  pushl $166
80106651:	68 a6 00 00 00       	push   $0xa6
  jmp alltraps
80106656:	e9 cf f4 ff ff       	jmp    80105b2a <alltraps>

8010665b <vector167>:
.globl vector167
vector167:
  pushl $0
8010665b:	6a 00                	push   $0x0
  pushl $167
8010665d:	68 a7 00 00 00       	push   $0xa7
  jmp alltraps
80106662:	e9 c3 f4 ff ff       	jmp    80105b2a <alltraps>

80106667 <vector168>:
.globl vector168
vector168:
  pushl $0
80106667:	6a 00                	push   $0x0
  pushl $168
80106669:	68 a8 00 00 00       	push   $0xa8
  jmp alltraps
8010666e:	e9 b7 f4 ff ff       	jmp    80105b2a <alltraps>

80106673 <vector169>:
.globl vector169
vector169:
  pushl $0
80106673:	6a 00                	push   $0x0
  pushl $169
80106675:	68 a9 00 00 00       	push   $0xa9
  jmp alltraps
8010667a:	e9 ab f4 ff ff       	jmp    80105b2a <alltraps>

8010667f <vector170>:
.globl vector170
vector170:
  pushl $0
8010667f:	6a 00                	push   $0x0
  pushl $170
80106681:	68 aa 00 00 00       	push   $0xaa
  jmp alltraps
80106686:	e9 9f f4 ff ff       	jmp    80105b2a <alltraps>

8010668b <vector171>:
.globl vector171
vector171:
  pushl $0
8010668b:	6a 00                	push   $0x0
  pushl $171
8010668d:	68 ab 00 00 00       	push   $0xab
  jmp alltraps
80106692:	e9 93 f4 ff ff       	jmp    80105b2a <alltraps>

80106697 <vector172>:
.globl vector172
vector172:
  pushl $0
80106697:	6a 00                	push   $0x0
  pushl $172
80106699:	68 ac 00 00 00       	push   $0xac
  jmp alltraps
8010669e:	e9 87 f4 ff ff       	jmp    80105b2a <alltraps>

801066a3 <vector173>:
.globl vector173
vector173:
  pushl $0
801066a3:	6a 00                	push   $0x0
  pushl $173
801066a5:	68 ad 00 00 00       	push   $0xad
  jmp alltraps
801066aa:	e9 7b f4 ff ff       	jmp    80105b2a <alltraps>

801066af <vector174>:
.globl vector174
vector174:
  pushl $0
801066af:	6a 00                	push   $0x0
  pushl $174
801066b1:	68 ae 00 00 00       	push   $0xae
  jmp alltraps
801066b6:	e9 6f f4 ff ff       	jmp    80105b2a <alltraps>

801066bb <vector175>:
.globl vector175
vector175:
  pushl $0
801066bb:	6a 00                	push   $0x0
  pushl $175
801066bd:	68 af 00 00 00       	push   $0xaf
  jmp alltraps
801066c2:	e9 63 f4 ff ff       	jmp    80105b2a <alltraps>

801066c7 <vector176>:
.globl vector176
vector176:
  pushl $0
801066c7:	6a 00                	push   $0x0
  pushl $176
801066c9:	68 b0 00 00 00       	push   $0xb0
  jmp alltraps
801066ce:	e9 57 f4 ff ff       	jmp    80105b2a <alltraps>

801066d3 <vector177>:
.globl vector177
vector177:
  pushl $0
801066d3:	6a 00                	push   $0x0
  pushl $177
801066d5:	68 b1 00 00 00       	push   $0xb1
  jmp alltraps
801066da:	e9 4b f4 ff ff       	jmp    80105b2a <alltraps>

801066df <vector178>:
.globl vector178
vector178:
  pushl $0
801066df:	6a 00                	push   $0x0
  pushl $178
801066e1:	68 b2 00 00 00       	push   $0xb2
  jmp alltraps
801066e6:	e9 3f f4 ff ff       	jmp    80105b2a <alltraps>

801066eb <vector179>:
.globl vector179
vector179:
  pushl $0
801066eb:	6a 00                	push   $0x0
  pushl $179
801066ed:	68 b3 00 00 00       	push   $0xb3
  jmp alltraps
801066f2:	e9 33 f4 ff ff       	jmp    80105b2a <alltraps>

801066f7 <vector180>:
.globl vector180
vector180:
  pushl $0
801066f7:	6a 00                	push   $0x0
  pushl $180
801066f9:	68 b4 00 00 00       	push   $0xb4
  jmp alltraps
801066fe:	e9 27 f4 ff ff       	jmp    80105b2a <alltraps>

80106703 <vector181>:
.globl vector181
vector181:
  pushl $0
80106703:	6a 00                	push   $0x0
  pushl $181
80106705:	68 b5 00 00 00       	push   $0xb5
  jmp alltraps
8010670a:	e9 1b f4 ff ff       	jmp    80105b2a <alltraps>

8010670f <vector182>:
.globl vector182
vector182:
  pushl $0
8010670f:	6a 00                	push   $0x0
  pushl $182
80106711:	68 b6 00 00 00       	push   $0xb6
  jmp alltraps
80106716:	e9 0f f4 ff ff       	jmp    80105b2a <alltraps>

8010671b <vector183>:
.globl vector183
vector183:
  pushl $0
8010671b:	6a 00                	push   $0x0
  pushl $183
8010671d:	68 b7 00 00 00       	push   $0xb7
  jmp alltraps
80106722:	e9 03 f4 ff ff       	jmp    80105b2a <alltraps>

80106727 <vector184>:
.globl vector184
vector184:
  pushl $0
80106727:	6a 00                	push   $0x0
  pushl $184
80106729:	68 b8 00 00 00       	push   $0xb8
  jmp alltraps
8010672e:	e9 f7 f3 ff ff       	jmp    80105b2a <alltraps>

80106733 <vector185>:
.globl vector185
vector185:
  pushl $0
80106733:	6a 00                	push   $0x0
  pushl $185
80106735:	68 b9 00 00 00       	push   $0xb9
  jmp alltraps
8010673a:	e9 eb f3 ff ff       	jmp    80105b2a <alltraps>

8010673f <vector186>:
.globl vector186
vector186:
  pushl $0
8010673f:	6a 00                	push   $0x0
  pushl $186
80106741:	68 ba 00 00 00       	push   $0xba
  jmp alltraps
80106746:	e9 df f3 ff ff       	jmp    80105b2a <alltraps>

8010674b <vector187>:
.globl vector187
vector187:
  pushl $0
8010674b:	6a 00                	push   $0x0
  pushl $187
8010674d:	68 bb 00 00 00       	push   $0xbb
  jmp alltraps
80106752:	e9 d3 f3 ff ff       	jmp    80105b2a <alltraps>

80106757 <vector188>:
.globl vector188
vector188:
  pushl $0
80106757:	6a 00                	push   $0x0
  pushl $188
80106759:	68 bc 00 00 00       	push   $0xbc
  jmp alltraps
8010675e:	e9 c7 f3 ff ff       	jmp    80105b2a <alltraps>

80106763 <vector189>:
.globl vector189
vector189:
  pushl $0
80106763:	6a 00                	push   $0x0
  pushl $189
80106765:	68 bd 00 00 00       	push   $0xbd
  jmp alltraps
8010676a:	e9 bb f3 ff ff       	jmp    80105b2a <alltraps>

8010676f <vector190>:
.globl vector190
vector190:
  pushl $0
8010676f:	6a 00                	push   $0x0
  pushl $190
80106771:	68 be 00 00 00       	push   $0xbe
  jmp alltraps
80106776:	e9 af f3 ff ff       	jmp    80105b2a <alltraps>

8010677b <vector191>:
.globl vector191
vector191:
  pushl $0
8010677b:	6a 00                	push   $0x0
  pushl $191
8010677d:	68 bf 00 00 00       	push   $0xbf
  jmp alltraps
80106782:	e9 a3 f3 ff ff       	jmp    80105b2a <alltraps>

80106787 <vector192>:
.globl vector192
vector192:
  pushl $0
80106787:	6a 00                	push   $0x0
  pushl $192
80106789:	68 c0 00 00 00       	push   $0xc0
  jmp alltraps
8010678e:	e9 97 f3 ff ff       	jmp    80105b2a <alltraps>

80106793 <vector193>:
.globl vector193
vector193:
  pushl $0
80106793:	6a 00                	push   $0x0
  pushl $193
80106795:	68 c1 00 00 00       	push   $0xc1
  jmp alltraps
8010679a:	e9 8b f3 ff ff       	jmp    80105b2a <alltraps>

8010679f <vector194>:
.globl vector194
vector194:
  pushl $0
8010679f:	6a 00                	push   $0x0
  pushl $194
801067a1:	68 c2 00 00 00       	push   $0xc2
  jmp alltraps
801067a6:	e9 7f f3 ff ff       	jmp    80105b2a <alltraps>

801067ab <vector195>:
.globl vector195
vector195:
  pushl $0
801067ab:	6a 00                	push   $0x0
  pushl $195
801067ad:	68 c3 00 00 00       	push   $0xc3
  jmp alltraps
801067b2:	e9 73 f3 ff ff       	jmp    80105b2a <alltraps>

801067b7 <vector196>:
.globl vector196
vector196:
  pushl $0
801067b7:	6a 00                	push   $0x0
  pushl $196
801067b9:	68 c4 00 00 00       	push   $0xc4
  jmp alltraps
801067be:	e9 67 f3 ff ff       	jmp    80105b2a <alltraps>

801067c3 <vector197>:
.globl vector197
vector197:
  pushl $0
801067c3:	6a 00                	push   $0x0
  pushl $197
801067c5:	68 c5 00 00 00       	push   $0xc5
  jmp alltraps
801067ca:	e9 5b f3 ff ff       	jmp    80105b2a <alltraps>

801067cf <vector198>:
.globl vector198
vector198:
  pushl $0
801067cf:	6a 00                	push   $0x0
  pushl $198
801067d1:	68 c6 00 00 00       	push   $0xc6
  jmp alltraps
801067d6:	e9 4f f3 ff ff       	jmp    80105b2a <alltraps>

801067db <vector199>:
.globl vector199
vector199:
  pushl $0
801067db:	6a 00                	push   $0x0
  pushl $199
801067dd:	68 c7 00 00 00       	push   $0xc7
  jmp alltraps
801067e2:	e9 43 f3 ff ff       	jmp    80105b2a <alltraps>

801067e7 <vector200>:
.globl vector200
vector200:
  pushl $0
801067e7:	6a 00                	push   $0x0
  pushl $200
801067e9:	68 c8 00 00 00       	push   $0xc8
  jmp alltraps
801067ee:	e9 37 f3 ff ff       	jmp    80105b2a <alltraps>

801067f3 <vector201>:
.globl vector201
vector201:
  pushl $0
801067f3:	6a 00                	push   $0x0
  pushl $201
801067f5:	68 c9 00 00 00       	push   $0xc9
  jmp alltraps
801067fa:	e9 2b f3 ff ff       	jmp    80105b2a <alltraps>

801067ff <vector202>:
.globl vector202
vector202:
  pushl $0
801067ff:	6a 00                	push   $0x0
  pushl $202
80106801:	68 ca 00 00 00       	push   $0xca
  jmp alltraps
80106806:	e9 1f f3 ff ff       	jmp    80105b2a <alltraps>

8010680b <vector203>:
.globl vector203
vector203:
  pushl $0
8010680b:	6a 00                	push   $0x0
  pushl $203
8010680d:	68 cb 00 00 00       	push   $0xcb
  jmp alltraps
80106812:	e9 13 f3 ff ff       	jmp    80105b2a <alltraps>

80106817 <vector204>:
.globl vector204
vector204:
  pushl $0
80106817:	6a 00                	push   $0x0
  pushl $204
80106819:	68 cc 00 00 00       	push   $0xcc
  jmp alltraps
8010681e:	e9 07 f3 ff ff       	jmp    80105b2a <alltraps>

80106823 <vector205>:
.globl vector205
vector205:
  pushl $0
80106823:	6a 00                	push   $0x0
  pushl $205
80106825:	68 cd 00 00 00       	push   $0xcd
  jmp alltraps
8010682a:	e9 fb f2 ff ff       	jmp    80105b2a <alltraps>

8010682f <vector206>:
.globl vector206
vector206:
  pushl $0
8010682f:	6a 00                	push   $0x0
  pushl $206
80106831:	68 ce 00 00 00       	push   $0xce
  jmp alltraps
80106836:	e9 ef f2 ff ff       	jmp    80105b2a <alltraps>

8010683b <vector207>:
.globl vector207
vector207:
  pushl $0
8010683b:	6a 00                	push   $0x0
  pushl $207
8010683d:	68 cf 00 00 00       	push   $0xcf
  jmp alltraps
80106842:	e9 e3 f2 ff ff       	jmp    80105b2a <alltraps>

80106847 <vector208>:
.globl vector208
vector208:
  pushl $0
80106847:	6a 00                	push   $0x0
  pushl $208
80106849:	68 d0 00 00 00       	push   $0xd0
  jmp alltraps
8010684e:	e9 d7 f2 ff ff       	jmp    80105b2a <alltraps>

80106853 <vector209>:
.globl vector209
vector209:
  pushl $0
80106853:	6a 00                	push   $0x0
  pushl $209
80106855:	68 d1 00 00 00       	push   $0xd1
  jmp alltraps
8010685a:	e9 cb f2 ff ff       	jmp    80105b2a <alltraps>

8010685f <vector210>:
.globl vector210
vector210:
  pushl $0
8010685f:	6a 00                	push   $0x0
  pushl $210
80106861:	68 d2 00 00 00       	push   $0xd2
  jmp alltraps
80106866:	e9 bf f2 ff ff       	jmp    80105b2a <alltraps>

8010686b <vector211>:
.globl vector211
vector211:
  pushl $0
8010686b:	6a 00                	push   $0x0
  pushl $211
8010686d:	68 d3 00 00 00       	push   $0xd3
  jmp alltraps
80106872:	e9 b3 f2 ff ff       	jmp    80105b2a <alltraps>

80106877 <vector212>:
.globl vector212
vector212:
  pushl $0
80106877:	6a 00                	push   $0x0
  pushl $212
80106879:	68 d4 00 00 00       	push   $0xd4
  jmp alltraps
8010687e:	e9 a7 f2 ff ff       	jmp    80105b2a <alltraps>

80106883 <vector213>:
.globl vector213
vector213:
  pushl $0
80106883:	6a 00                	push   $0x0
  pushl $213
80106885:	68 d5 00 00 00       	push   $0xd5
  jmp alltraps
8010688a:	e9 9b f2 ff ff       	jmp    80105b2a <alltraps>

8010688f <vector214>:
.globl vector214
vector214:
  pushl $0
8010688f:	6a 00                	push   $0x0
  pushl $214
80106891:	68 d6 00 00 00       	push   $0xd6
  jmp alltraps
80106896:	e9 8f f2 ff ff       	jmp    80105b2a <alltraps>

8010689b <vector215>:
.globl vector215
vector215:
  pushl $0
8010689b:	6a 00                	push   $0x0
  pushl $215
8010689d:	68 d7 00 00 00       	push   $0xd7
  jmp alltraps
801068a2:	e9 83 f2 ff ff       	jmp    80105b2a <alltraps>

801068a7 <vector216>:
.globl vector216
vector216:
  pushl $0
801068a7:	6a 00                	push   $0x0
  pushl $216
801068a9:	68 d8 00 00 00       	push   $0xd8
  jmp alltraps
801068ae:	e9 77 f2 ff ff       	jmp    80105b2a <alltraps>

801068b3 <vector217>:
.globl vector217
vector217:
  pushl $0
801068b3:	6a 00                	push   $0x0
  pushl $217
801068b5:	68 d9 00 00 00       	push   $0xd9
  jmp alltraps
801068ba:	e9 6b f2 ff ff       	jmp    80105b2a <alltraps>

801068bf <vector218>:
.globl vector218
vector218:
  pushl $0
801068bf:	6a 00                	push   $0x0
  pushl $218
801068c1:	68 da 00 00 00       	push   $0xda
  jmp alltraps
801068c6:	e9 5f f2 ff ff       	jmp    80105b2a <alltraps>

801068cb <vector219>:
.globl vector219
vector219:
  pushl $0
801068cb:	6a 00                	push   $0x0
  pushl $219
801068cd:	68 db 00 00 00       	push   $0xdb
  jmp alltraps
801068d2:	e9 53 f2 ff ff       	jmp    80105b2a <alltraps>

801068d7 <vector220>:
.globl vector220
vector220:
  pushl $0
801068d7:	6a 00                	push   $0x0
  pushl $220
801068d9:	68 dc 00 00 00       	push   $0xdc
  jmp alltraps
801068de:	e9 47 f2 ff ff       	jmp    80105b2a <alltraps>

801068e3 <vector221>:
.globl vector221
vector221:
  pushl $0
801068e3:	6a 00                	push   $0x0
  pushl $221
801068e5:	68 dd 00 00 00       	push   $0xdd
  jmp alltraps
801068ea:	e9 3b f2 ff ff       	jmp    80105b2a <alltraps>

801068ef <vector222>:
.globl vector222
vector222:
  pushl $0
801068ef:	6a 00                	push   $0x0
  pushl $222
801068f1:	68 de 00 00 00       	push   $0xde
  jmp alltraps
801068f6:	e9 2f f2 ff ff       	jmp    80105b2a <alltraps>

801068fb <vector223>:
.globl vector223
vector223:
  pushl $0
801068fb:	6a 00                	push   $0x0
  pushl $223
801068fd:	68 df 00 00 00       	push   $0xdf
  jmp alltraps
80106902:	e9 23 f2 ff ff       	jmp    80105b2a <alltraps>

80106907 <vector224>:
.globl vector224
vector224:
  pushl $0
80106907:	6a 00                	push   $0x0
  pushl $224
80106909:	68 e0 00 00 00       	push   $0xe0
  jmp alltraps
8010690e:	e9 17 f2 ff ff       	jmp    80105b2a <alltraps>

80106913 <vector225>:
.globl vector225
vector225:
  pushl $0
80106913:	6a 00                	push   $0x0
  pushl $225
80106915:	68 e1 00 00 00       	push   $0xe1
  jmp alltraps
8010691a:	e9 0b f2 ff ff       	jmp    80105b2a <alltraps>

8010691f <vector226>:
.globl vector226
vector226:
  pushl $0
8010691f:	6a 00                	push   $0x0
  pushl $226
80106921:	68 e2 00 00 00       	push   $0xe2
  jmp alltraps
80106926:	e9 ff f1 ff ff       	jmp    80105b2a <alltraps>

8010692b <vector227>:
.globl vector227
vector227:
  pushl $0
8010692b:	6a 00                	push   $0x0
  pushl $227
8010692d:	68 e3 00 00 00       	push   $0xe3
  jmp alltraps
80106932:	e9 f3 f1 ff ff       	jmp    80105b2a <alltraps>

80106937 <vector228>:
.globl vector228
vector228:
  pushl $0
80106937:	6a 00                	push   $0x0
  pushl $228
80106939:	68 e4 00 00 00       	push   $0xe4
  jmp alltraps
8010693e:	e9 e7 f1 ff ff       	jmp    80105b2a <alltraps>

80106943 <vector229>:
.globl vector229
vector229:
  pushl $0
80106943:	6a 00                	push   $0x0
  pushl $229
80106945:	68 e5 00 00 00       	push   $0xe5
  jmp alltraps
8010694a:	e9 db f1 ff ff       	jmp    80105b2a <alltraps>

8010694f <vector230>:
.globl vector230
vector230:
  pushl $0
8010694f:	6a 00                	push   $0x0
  pushl $230
80106951:	68 e6 00 00 00       	push   $0xe6
  jmp alltraps
80106956:	e9 cf f1 ff ff       	jmp    80105b2a <alltraps>

8010695b <vector231>:
.globl vector231
vector231:
  pushl $0
8010695b:	6a 00                	push   $0x0
  pushl $231
8010695d:	68 e7 00 00 00       	push   $0xe7
  jmp alltraps
80106962:	e9 c3 f1 ff ff       	jmp    80105b2a <alltraps>

80106967 <vector232>:
.globl vector232
vector232:
  pushl $0
80106967:	6a 00                	push   $0x0
  pushl $232
80106969:	68 e8 00 00 00       	push   $0xe8
  jmp alltraps
8010696e:	e9 b7 f1 ff ff       	jmp    80105b2a <alltraps>

80106973 <vector233>:
.globl vector233
vector233:
  pushl $0
80106973:	6a 00                	push   $0x0
  pushl $233
80106975:	68 e9 00 00 00       	push   $0xe9
  jmp alltraps
8010697a:	e9 ab f1 ff ff       	jmp    80105b2a <alltraps>

8010697f <vector234>:
.globl vector234
vector234:
  pushl $0
8010697f:	6a 00                	push   $0x0
  pushl $234
80106981:	68 ea 00 00 00       	push   $0xea
  jmp alltraps
80106986:	e9 9f f1 ff ff       	jmp    80105b2a <alltraps>

8010698b <vector235>:
.globl vector235
vector235:
  pushl $0
8010698b:	6a 00                	push   $0x0
  pushl $235
8010698d:	68 eb 00 00 00       	push   $0xeb
  jmp alltraps
80106992:	e9 93 f1 ff ff       	jmp    80105b2a <alltraps>

80106997 <vector236>:
.globl vector236
vector236:
  pushl $0
80106997:	6a 00                	push   $0x0
  pushl $236
80106999:	68 ec 00 00 00       	push   $0xec
  jmp alltraps
8010699e:	e9 87 f1 ff ff       	jmp    80105b2a <alltraps>

801069a3 <vector237>:
.globl vector237
vector237:
  pushl $0
801069a3:	6a 00                	push   $0x0
  pushl $237
801069a5:	68 ed 00 00 00       	push   $0xed
  jmp alltraps
801069aa:	e9 7b f1 ff ff       	jmp    80105b2a <alltraps>

801069af <vector238>:
.globl vector238
vector238:
  pushl $0
801069af:	6a 00                	push   $0x0
  pushl $238
801069b1:	68 ee 00 00 00       	push   $0xee
  jmp alltraps
801069b6:	e9 6f f1 ff ff       	jmp    80105b2a <alltraps>

801069bb <vector239>:
.globl vector239
vector239:
  pushl $0
801069bb:	6a 00                	push   $0x0
  pushl $239
801069bd:	68 ef 00 00 00       	push   $0xef
  jmp alltraps
801069c2:	e9 63 f1 ff ff       	jmp    80105b2a <alltraps>

801069c7 <vector240>:
.globl vector240
vector240:
  pushl $0
801069c7:	6a 00                	push   $0x0
  pushl $240
801069c9:	68 f0 00 00 00       	push   $0xf0
  jmp alltraps
801069ce:	e9 57 f1 ff ff       	jmp    80105b2a <alltraps>

801069d3 <vector241>:
.globl vector241
vector241:
  pushl $0
801069d3:	6a 00                	push   $0x0
  pushl $241
801069d5:	68 f1 00 00 00       	push   $0xf1
  jmp alltraps
801069da:	e9 4b f1 ff ff       	jmp    80105b2a <alltraps>

801069df <vector242>:
.globl vector242
vector242:
  pushl $0
801069df:	6a 00                	push   $0x0
  pushl $242
801069e1:	68 f2 00 00 00       	push   $0xf2
  jmp alltraps
801069e6:	e9 3f f1 ff ff       	jmp    80105b2a <alltraps>

801069eb <vector243>:
.globl vector243
vector243:
  pushl $0
801069eb:	6a 00                	push   $0x0
  pushl $243
801069ed:	68 f3 00 00 00       	push   $0xf3
  jmp alltraps
801069f2:	e9 33 f1 ff ff       	jmp    80105b2a <alltraps>

801069f7 <vector244>:
.globl vector244
vector244:
  pushl $0
801069f7:	6a 00                	push   $0x0
  pushl $244
801069f9:	68 f4 00 00 00       	push   $0xf4
  jmp alltraps
801069fe:	e9 27 f1 ff ff       	jmp    80105b2a <alltraps>

80106a03 <vector245>:
.globl vector245
vector245:
  pushl $0
80106a03:	6a 00                	push   $0x0
  pushl $245
80106a05:	68 f5 00 00 00       	push   $0xf5
  jmp alltraps
80106a0a:	e9 1b f1 ff ff       	jmp    80105b2a <alltraps>

80106a0f <vector246>:
.globl vector246
vector246:
  pushl $0
80106a0f:	6a 00                	push   $0x0
  pushl $246
80106a11:	68 f6 00 00 00       	push   $0xf6
  jmp alltraps
80106a16:	e9 0f f1 ff ff       	jmp    80105b2a <alltraps>

80106a1b <vector247>:
.globl vector247
vector247:
  pushl $0
80106a1b:	6a 00                	push   $0x0
  pushl $247
80106a1d:	68 f7 00 00 00       	push   $0xf7
  jmp alltraps
80106a22:	e9 03 f1 ff ff       	jmp    80105b2a <alltraps>

80106a27 <vector248>:
.globl vector248
vector248:
  pushl $0
80106a27:	6a 00                	push   $0x0
  pushl $248
80106a29:	68 f8 00 00 00       	push   $0xf8
  jmp alltraps
80106a2e:	e9 f7 f0 ff ff       	jmp    80105b2a <alltraps>

80106a33 <vector249>:
.globl vector249
vector249:
  pushl $0
80106a33:	6a 00                	push   $0x0
  pushl $249
80106a35:	68 f9 00 00 00       	push   $0xf9
  jmp alltraps
80106a3a:	e9 eb f0 ff ff       	jmp    80105b2a <alltraps>

80106a3f <vector250>:
.globl vector250
vector250:
  pushl $0
80106a3f:	6a 00                	push   $0x0
  pushl $250
80106a41:	68 fa 00 00 00       	push   $0xfa
  jmp alltraps
80106a46:	e9 df f0 ff ff       	jmp    80105b2a <alltraps>

80106a4b <vector251>:
.globl vector251
vector251:
  pushl $0
80106a4b:	6a 00                	push   $0x0
  pushl $251
80106a4d:	68 fb 00 00 00       	push   $0xfb
  jmp alltraps
80106a52:	e9 d3 f0 ff ff       	jmp    80105b2a <alltraps>

80106a57 <vector252>:
.globl vector252
vector252:
  pushl $0
80106a57:	6a 00                	push   $0x0
  pushl $252
80106a59:	68 fc 00 00 00       	push   $0xfc
  jmp alltraps
80106a5e:	e9 c7 f0 ff ff       	jmp    80105b2a <alltraps>

80106a63 <vector253>:
.globl vector253
vector253:
  pushl $0
80106a63:	6a 00                	push   $0x0
  pushl $253
80106a65:	68 fd 00 00 00       	push   $0xfd
  jmp alltraps
80106a6a:	e9 bb f0 ff ff       	jmp    80105b2a <alltraps>

80106a6f <vector254>:
.globl vector254
vector254:
  pushl $0
80106a6f:	6a 00                	push   $0x0
  pushl $254
80106a71:	68 fe 00 00 00       	push   $0xfe
  jmp alltraps
80106a76:	e9 af f0 ff ff       	jmp    80105b2a <alltraps>

80106a7b <vector255>:
.globl vector255
vector255:
  pushl $0
80106a7b:	6a 00                	push   $0x0
  pushl $255
80106a7d:	68 ff 00 00 00       	push   $0xff
  jmp alltraps
80106a82:	e9 a3 f0 ff ff       	jmp    80105b2a <alltraps>
80106a87:	66 90                	xchg   %ax,%ax
80106a89:	66 90                	xchg   %ax,%ax
80106a8b:	66 90                	xchg   %ax,%ax
80106a8d:	66 90                	xchg   %ax,%ax
80106a8f:	90                   	nop

80106a90 <deallocuvm.part.0>:
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80106a90:	55                   	push   %ebp
80106a91:	89 e5                	mov    %esp,%ebp
80106a93:	57                   	push   %edi
80106a94:	56                   	push   %esi
80106a95:	53                   	push   %ebx
  uint a, pa;

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
80106a96:	8d 99 ff 0f 00 00    	lea    0xfff(%ecx),%ebx
80106a9c:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80106aa2:	83 ec 1c             	sub    $0x1c,%esp
  for(; a  < oldsz; a += PGSIZE){
80106aa5:	39 d3                	cmp    %edx,%ebx
80106aa7:	73 56                	jae    80106aff <deallocuvm.part.0+0x6f>
80106aa9:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80106aac:	89 c6                	mov    %eax,%esi
80106aae:	89 d7                	mov    %edx,%edi
80106ab0:	eb 12                	jmp    80106ac4 <deallocuvm.part.0+0x34>
80106ab2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    pte = walkpgdir(pgdir, (char*)a, 0);
    if(!pte)
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
80106ab8:	83 c2 01             	add    $0x1,%edx
80106abb:	89 d3                	mov    %edx,%ebx
80106abd:	c1 e3 16             	shl    $0x16,%ebx
  for(; a  < oldsz; a += PGSIZE){
80106ac0:	39 fb                	cmp    %edi,%ebx
80106ac2:	73 38                	jae    80106afc <deallocuvm.part.0+0x6c>
  pde = &pgdir[PDX(va)];
80106ac4:	89 da                	mov    %ebx,%edx
80106ac6:	c1 ea 16             	shr    $0x16,%edx
  if(*pde & PTE_P){
80106ac9:	8b 04 96             	mov    (%esi,%edx,4),%eax
80106acc:	a8 01                	test   $0x1,%al
80106ace:	74 e8                	je     80106ab8 <deallocuvm.part.0+0x28>
  return &pgtab[PTX(va)];
80106ad0:	89 d9                	mov    %ebx,%ecx
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80106ad2:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  return &pgtab[PTX(va)];
80106ad7:	c1 e9 0a             	shr    $0xa,%ecx
80106ada:	81 e1 fc 0f 00 00    	and    $0xffc,%ecx
80106ae0:	8d 84 08 00 00 00 80 	lea    -0x80000000(%eax,%ecx,1),%eax
    if(!pte)
80106ae7:	85 c0                	test   %eax,%eax
80106ae9:	74 cd                	je     80106ab8 <deallocuvm.part.0+0x28>
    else if((*pte & PTE_P) != 0){
80106aeb:	8b 10                	mov    (%eax),%edx
80106aed:	f6 c2 01             	test   $0x1,%dl
80106af0:	75 1e                	jne    80106b10 <deallocuvm.part.0+0x80>
  for(; a  < oldsz; a += PGSIZE){
80106af2:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106af8:	39 fb                	cmp    %edi,%ebx
80106afa:	72 c8                	jb     80106ac4 <deallocuvm.part.0+0x34>
80106afc:	8b 4d e0             	mov    -0x20(%ebp),%ecx
      kfree(v);
      *pte = 0;
    }
  }
  return newsz;
}
80106aff:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106b02:	89 c8                	mov    %ecx,%eax
80106b04:	5b                   	pop    %ebx
80106b05:	5e                   	pop    %esi
80106b06:	5f                   	pop    %edi
80106b07:	5d                   	pop    %ebp
80106b08:	c3                   	ret
80106b09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      if(pa == 0)
80106b10:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
80106b16:	74 26                	je     80106b3e <deallocuvm.part.0+0xae>
      kfree(v);
80106b18:	83 ec 0c             	sub    $0xc,%esp
      char *v = P2V(pa);
80106b1b:	81 c2 00 00 00 80    	add    $0x80000000,%edx
80106b21:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  for(; a  < oldsz; a += PGSIZE){
80106b24:	81 c3 00 10 00 00    	add    $0x1000,%ebx
      kfree(v);
80106b2a:	52                   	push   %edx
80106b2b:	e8 d0 b9 ff ff       	call   80102500 <kfree>
      *pte = 0;
80106b30:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  for(; a  < oldsz; a += PGSIZE){
80106b33:	83 c4 10             	add    $0x10,%esp
      *pte = 0;
80106b36:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80106b3c:	eb 82                	jmp    80106ac0 <deallocuvm.part.0+0x30>
        panic("kfree");
80106b3e:	83 ec 0c             	sub    $0xc,%esp
80106b41:	68 2c 84 10 80       	push   $0x8010842c
80106b46:	e8 35 98 ff ff       	call   80100380 <panic>
80106b4b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80106b50 <seginit>:
{
80106b50:	55                   	push   %ebp
80106b51:	89 e5                	mov    %esp,%ebp
80106b53:	83 ec 18             	sub    $0x18,%esp
  c = &cpus[cpuid()];
80106b56:	e8 55 ce ff ff       	call   801039b0 <cpuid>
  pd[0] = size-1;
80106b5b:	ba 2f 00 00 00       	mov    $0x2f,%edx
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
80106b60:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
80106b66:	66 89 55 f2          	mov    %dx,-0xe(%ebp)
80106b6a:	c7 80 78 a8 13 80 ff 	movl   $0xffff,-0x7fec5788(%eax)
80106b71:	ff 00 00 
80106b74:	c7 80 7c a8 13 80 00 	movl   $0xcf9a00,-0x7fec5784(%eax)
80106b7b:	9a cf 00 
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80106b7e:	c7 80 80 a8 13 80 ff 	movl   $0xffff,-0x7fec5780(%eax)
80106b85:	ff 00 00 
80106b88:	c7 80 84 a8 13 80 00 	movl   $0xcf9200,-0x7fec577c(%eax)
80106b8f:	92 cf 00 
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80106b92:	c7 80 88 a8 13 80 ff 	movl   $0xffff,-0x7fec5778(%eax)
80106b99:	ff 00 00 
80106b9c:	c7 80 8c a8 13 80 00 	movl   $0xcffa00,-0x7fec5774(%eax)
80106ba3:	fa cf 00 
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80106ba6:	c7 80 90 a8 13 80 ff 	movl   $0xffff,-0x7fec5770(%eax)
80106bad:	ff 00 00 
80106bb0:	c7 80 94 a8 13 80 00 	movl   $0xcff200,-0x7fec576c(%eax)
80106bb7:	f2 cf 00 
  lgdt(c->gdt, sizeof(c->gdt));
80106bba:	05 70 a8 13 80       	add    $0x8013a870,%eax
  pd[1] = (uint)p;
80106bbf:	66 89 45 f4          	mov    %ax,-0xc(%ebp)
  pd[2] = (uint)p >> 16;
80106bc3:	c1 e8 10             	shr    $0x10,%eax
80106bc6:	66 89 45 f6          	mov    %ax,-0xa(%ebp)
  asm volatile("lgdt (%0)" : : "r" (pd));
80106bca:	8d 45 f2             	lea    -0xe(%ebp),%eax
80106bcd:	0f 01 10             	lgdtl  (%eax)
}
80106bd0:	c9                   	leave
80106bd1:	c3                   	ret
80106bd2:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80106bd9:	00 
80106bda:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80106be0 <mappages>:
{
80106be0:	55                   	push   %ebp
80106be1:	89 e5                	mov    %esp,%ebp
80106be3:	57                   	push   %edi
80106be4:	56                   	push   %esi
80106be5:	53                   	push   %ebx
80106be6:	83 ec 1c             	sub    $0x1c,%esp
80106be9:	8b 45 0c             	mov    0xc(%ebp),%eax
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
80106bec:	8b 55 10             	mov    0x10(%ebp),%edx
  a = (char*)PGROUNDDOWN((uint)va);
80106bef:	89 c3                	mov    %eax,%ebx
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
80106bf1:	8d 44 10 ff          	lea    -0x1(%eax,%edx,1),%eax
80106bf5:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  a = (char*)PGROUNDDOWN((uint)va);
80106bfa:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
80106c00:	89 45 e0             	mov    %eax,-0x20(%ebp)
80106c03:	8b 45 14             	mov    0x14(%ebp),%eax
80106c06:	29 d8                	sub    %ebx,%eax
80106c08:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80106c0b:	eb 3c                	jmp    80106c49 <mappages+0x69>
80106c0d:	8d 76 00             	lea    0x0(%esi),%esi
  return &pgtab[PTX(va)];
80106c10:	89 da                	mov    %ebx,%edx
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80106c12:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  return &pgtab[PTX(va)];
80106c17:	c1 ea 0a             	shr    $0xa,%edx
80106c1a:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
80106c20:	8d 84 10 00 00 00 80 	lea    -0x80000000(%eax,%edx,1),%eax
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
80106c27:	85 c0                	test   %eax,%eax
80106c29:	74 75                	je     80106ca0 <mappages+0xc0>
    if(*pte & PTE_P)
80106c2b:	f6 00 01             	testb  $0x1,(%eax)
80106c2e:	0f 85 86 00 00 00    	jne    80106cba <mappages+0xda>
    *pte = pa | perm | PTE_P;
80106c34:	0b 75 18             	or     0x18(%ebp),%esi
80106c37:	83 ce 01             	or     $0x1,%esi
80106c3a:	89 30                	mov    %esi,(%eax)
    if(a == last)
80106c3c:	8b 45 e0             	mov    -0x20(%ebp),%eax
80106c3f:	39 c3                	cmp    %eax,%ebx
80106c41:	74 6d                	je     80106cb0 <mappages+0xd0>
    a += PGSIZE;
80106c43:	81 c3 00 10 00 00    	add    $0x1000,%ebx
  for(;;){
80106c49:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  pde = &pgdir[PDX(va)];
80106c4c:	8b 4d 08             	mov    0x8(%ebp),%ecx
80106c4f:	8d 34 03             	lea    (%ebx,%eax,1),%esi
80106c52:	89 d8                	mov    %ebx,%eax
80106c54:	c1 e8 16             	shr    $0x16,%eax
80106c57:	8d 3c 81             	lea    (%ecx,%eax,4),%edi
  if(*pde & PTE_P){
80106c5a:	8b 07                	mov    (%edi),%eax
80106c5c:	a8 01                	test   $0x1,%al
80106c5e:	75 b0                	jne    80106c10 <mappages+0x30>
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
80106c60:	e8 5b ba ff ff       	call   801026c0 <kalloc>
80106c65:	85 c0                	test   %eax,%eax
80106c67:	74 37                	je     80106ca0 <mappages+0xc0>
    memset(pgtab, 0, PGSIZE);
80106c69:	83 ec 04             	sub    $0x4,%esp
80106c6c:	68 00 10 00 00       	push   $0x1000
80106c71:	6a 00                	push   $0x0
80106c73:	50                   	push   %eax
80106c74:	89 45 dc             	mov    %eax,-0x24(%ebp)
80106c77:	e8 24 db ff ff       	call   801047a0 <memset>
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
80106c7c:	8b 55 dc             	mov    -0x24(%ebp),%edx
  return &pgtab[PTX(va)];
80106c7f:	83 c4 10             	add    $0x10,%esp
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
80106c82:	8d 82 00 00 00 80    	lea    -0x80000000(%edx),%eax
80106c88:	83 c8 07             	or     $0x7,%eax
80106c8b:	89 07                	mov    %eax,(%edi)
  return &pgtab[PTX(va)];
80106c8d:	89 d8                	mov    %ebx,%eax
80106c8f:	c1 e8 0a             	shr    $0xa,%eax
80106c92:	25 fc 0f 00 00       	and    $0xffc,%eax
80106c97:	01 d0                	add    %edx,%eax
80106c99:	eb 90                	jmp    80106c2b <mappages+0x4b>
80106c9b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
}
80106ca0:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
80106ca3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106ca8:	5b                   	pop    %ebx
80106ca9:	5e                   	pop    %esi
80106caa:	5f                   	pop    %edi
80106cab:	5d                   	pop    %ebp
80106cac:	c3                   	ret
80106cad:	8d 76 00             	lea    0x0(%esi),%esi
80106cb0:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80106cb3:	31 c0                	xor    %eax,%eax
}
80106cb5:	5b                   	pop    %ebx
80106cb6:	5e                   	pop    %esi
80106cb7:	5f                   	pop    %edi
80106cb8:	5d                   	pop    %ebp
80106cb9:	c3                   	ret
      panic("remap");
80106cba:	83 ec 0c             	sub    $0xc,%esp
80106cbd:	68 60 86 10 80       	push   $0x80108660
80106cc2:	e8 b9 96 ff ff       	call   80100380 <panic>
80106cc7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80106cce:	00 
80106ccf:	90                   	nop

80106cd0 <switchkvm>:
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80106cd0:	a1 24 d5 33 80       	mov    0x8033d524,%eax
80106cd5:	05 00 00 00 80       	add    $0x80000000,%eax
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
80106cda:	0f 22 d8             	mov    %eax,%cr3
}
80106cdd:	c3                   	ret
80106cde:	66 90                	xchg   %ax,%ax

80106ce0 <switchuvm>:
{
80106ce0:	55                   	push   %ebp
80106ce1:	89 e5                	mov    %esp,%ebp
80106ce3:	57                   	push   %edi
80106ce4:	56                   	push   %esi
80106ce5:	53                   	push   %ebx
80106ce6:	83 ec 1c             	sub    $0x1c,%esp
80106ce9:	8b 75 08             	mov    0x8(%ebp),%esi
  if(p == 0)
80106cec:	85 f6                	test   %esi,%esi
80106cee:	0f 84 cb 00 00 00    	je     80106dbf <switchuvm+0xdf>
  if(p->kstack == 0)
80106cf4:	8b 46 08             	mov    0x8(%esi),%eax
80106cf7:	85 c0                	test   %eax,%eax
80106cf9:	0f 84 da 00 00 00    	je     80106dd9 <switchuvm+0xf9>
  if(p->pgdir == 0)
80106cff:	8b 46 04             	mov    0x4(%esi),%eax
80106d02:	85 c0                	test   %eax,%eax
80106d04:	0f 84 c2 00 00 00    	je     80106dcc <switchuvm+0xec>
  pushcli();
80106d0a:	e8 41 d8 ff ff       	call   80104550 <pushcli>
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
80106d0f:	e8 3c cc ff ff       	call   80103950 <mycpu>
80106d14:	89 c3                	mov    %eax,%ebx
80106d16:	e8 35 cc ff ff       	call   80103950 <mycpu>
80106d1b:	89 c7                	mov    %eax,%edi
80106d1d:	e8 2e cc ff ff       	call   80103950 <mycpu>
80106d22:	83 c7 08             	add    $0x8,%edi
80106d25:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80106d28:	e8 23 cc ff ff       	call   80103950 <mycpu>
80106d2d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80106d30:	ba 67 00 00 00       	mov    $0x67,%edx
80106d35:	66 89 bb 9a 00 00 00 	mov    %di,0x9a(%ebx)
80106d3c:	83 c0 08             	add    $0x8,%eax
80106d3f:	66 89 93 98 00 00 00 	mov    %dx,0x98(%ebx)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
80106d46:	bf ff ff ff ff       	mov    $0xffffffff,%edi
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
80106d4b:	83 c1 08             	add    $0x8,%ecx
80106d4e:	c1 e8 18             	shr    $0x18,%eax
80106d51:	c1 e9 10             	shr    $0x10,%ecx
80106d54:	88 83 9f 00 00 00    	mov    %al,0x9f(%ebx)
80106d5a:	88 8b 9c 00 00 00    	mov    %cl,0x9c(%ebx)
80106d60:	b9 99 40 00 00       	mov    $0x4099,%ecx
80106d65:	66 89 8b 9d 00 00 00 	mov    %cx,0x9d(%ebx)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
80106d6c:	bb 10 00 00 00       	mov    $0x10,%ebx
  mycpu()->gdt[SEG_TSS].s = 0;
80106d71:	e8 da cb ff ff       	call   80103950 <mycpu>
80106d76:	80 a0 9d 00 00 00 ef 	andb   $0xef,0x9d(%eax)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
80106d7d:	e8 ce cb ff ff       	call   80103950 <mycpu>
80106d82:	66 89 58 10          	mov    %bx,0x10(%eax)
  mycpu()->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
80106d86:	8b 5e 08             	mov    0x8(%esi),%ebx
80106d89:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106d8f:	e8 bc cb ff ff       	call   80103950 <mycpu>
80106d94:	89 58 0c             	mov    %ebx,0xc(%eax)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
80106d97:	e8 b4 cb ff ff       	call   80103950 <mycpu>
80106d9c:	66 89 78 6e          	mov    %di,0x6e(%eax)
  asm volatile("ltr %0" : : "r" (sel));
80106da0:	b8 28 00 00 00       	mov    $0x28,%eax
80106da5:	0f 00 d8             	ltr    %eax
  lcr3(V2P(p->pgdir));  // switch to process's address space
80106da8:	8b 46 04             	mov    0x4(%esi),%eax
80106dab:	05 00 00 00 80       	add    $0x80000000,%eax
  asm volatile("movl %0,%%cr3" : : "r" (val));
80106db0:	0f 22 d8             	mov    %eax,%cr3
}
80106db3:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106db6:	5b                   	pop    %ebx
80106db7:	5e                   	pop    %esi
80106db8:	5f                   	pop    %edi
80106db9:	5d                   	pop    %ebp
  popcli();
80106dba:	e9 e1 d7 ff ff       	jmp    801045a0 <popcli>
    panic("switchuvm: no process");
80106dbf:	83 ec 0c             	sub    $0xc,%esp
80106dc2:	68 66 86 10 80       	push   $0x80108666
80106dc7:	e8 b4 95 ff ff       	call   80100380 <panic>
    panic("switchuvm: no pgdir");
80106dcc:	83 ec 0c             	sub    $0xc,%esp
80106dcf:	68 91 86 10 80       	push   $0x80108691
80106dd4:	e8 a7 95 ff ff       	call   80100380 <panic>
    panic("switchuvm: no kstack");
80106dd9:	83 ec 0c             	sub    $0xc,%esp
80106ddc:	68 7c 86 10 80       	push   $0x8010867c
80106de1:	e8 9a 95 ff ff       	call   80100380 <panic>
80106de6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80106ded:	00 
80106dee:	66 90                	xchg   %ax,%ax

80106df0 <inituvm>:
{
80106df0:	55                   	push   %ebp
80106df1:	89 e5                	mov    %esp,%ebp
80106df3:	57                   	push   %edi
80106df4:	56                   	push   %esi
80106df5:	53                   	push   %ebx
80106df6:	83 ec 1c             	sub    $0x1c,%esp
80106df9:	8b 75 10             	mov    0x10(%ebp),%esi
80106dfc:	8b 55 08             	mov    0x8(%ebp),%edx
80106dff:	8b 7d 0c             	mov    0xc(%ebp),%edi
  if(sz >= PGSIZE)
80106e02:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
80106e08:	77 50                	ja     80106e5a <inituvm+0x6a>
80106e0a:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  mem = kalloc();
80106e0d:	e8 ae b8 ff ff       	call   801026c0 <kalloc>
  memset(mem, 0, PGSIZE);
80106e12:	83 ec 04             	sub    $0x4,%esp
80106e15:	68 00 10 00 00       	push   $0x1000
  mem = kalloc();
80106e1a:	89 c3                	mov    %eax,%ebx
  memset(mem, 0, PGSIZE);
80106e1c:	6a 00                	push   $0x0
80106e1e:	50                   	push   %eax
80106e1f:	e8 7c d9 ff ff       	call   801047a0 <memset>
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
80106e24:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80106e2a:	c7 04 24 06 00 00 00 	movl   $0x6,(%esp)
80106e31:	50                   	push   %eax
80106e32:	68 00 10 00 00       	push   $0x1000
80106e37:	6a 00                	push   $0x0
80106e39:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80106e3c:	52                   	push   %edx
80106e3d:	e8 9e fd ff ff       	call   80106be0 <mappages>
  memmove(mem, init, sz);
80106e42:	83 c4 20             	add    $0x20,%esp
80106e45:	89 75 10             	mov    %esi,0x10(%ebp)
80106e48:	89 7d 0c             	mov    %edi,0xc(%ebp)
80106e4b:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
80106e4e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106e51:	5b                   	pop    %ebx
80106e52:	5e                   	pop    %esi
80106e53:	5f                   	pop    %edi
80106e54:	5d                   	pop    %ebp
  memmove(mem, init, sz);
80106e55:	e9 d6 d9 ff ff       	jmp    80104830 <memmove>
    panic("inituvm: more than a page");
80106e5a:	83 ec 0c             	sub    $0xc,%esp
80106e5d:	68 a5 86 10 80       	push   $0x801086a5
80106e62:	e8 19 95 ff ff       	call   80100380 <panic>
80106e67:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80106e6e:	00 
80106e6f:	90                   	nop

80106e70 <loaduvm>:
{
80106e70:	55                   	push   %ebp
80106e71:	89 e5                	mov    %esp,%ebp
80106e73:	57                   	push   %edi
80106e74:	56                   	push   %esi
80106e75:	53                   	push   %ebx
80106e76:	83 ec 0c             	sub    $0xc,%esp
  if((uint) addr % PGSIZE != 0)
80106e79:	8b 75 0c             	mov    0xc(%ebp),%esi
{
80106e7c:	8b 7d 18             	mov    0x18(%ebp),%edi
  if((uint) addr % PGSIZE != 0)
80106e7f:	81 e6 ff 0f 00 00    	and    $0xfff,%esi
80106e85:	0f 85 a2 00 00 00    	jne    80106f2d <loaduvm+0xbd>
  for(i = 0; i < sz; i += PGSIZE){
80106e8b:	85 ff                	test   %edi,%edi
80106e8d:	74 7d                	je     80106f0c <loaduvm+0x9c>
80106e8f:	90                   	nop
  pde = &pgdir[PDX(va)];
80106e90:	8b 45 0c             	mov    0xc(%ebp),%eax
  if(*pde & PTE_P){
80106e93:	8b 55 08             	mov    0x8(%ebp),%edx
80106e96:	01 f0                	add    %esi,%eax
  pde = &pgdir[PDX(va)];
80106e98:	89 c1                	mov    %eax,%ecx
80106e9a:	c1 e9 16             	shr    $0x16,%ecx
  if(*pde & PTE_P){
80106e9d:	8b 0c 8a             	mov    (%edx,%ecx,4),%ecx
80106ea0:	f6 c1 01             	test   $0x1,%cl
80106ea3:	75 13                	jne    80106eb8 <loaduvm+0x48>
      panic("loaduvm: address should exist");
80106ea5:	83 ec 0c             	sub    $0xc,%esp
80106ea8:	68 bf 86 10 80       	push   $0x801086bf
80106ead:	e8 ce 94 ff ff       	call   80100380 <panic>
80106eb2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return &pgtab[PTX(va)];
80106eb8:	c1 e8 0a             	shr    $0xa,%eax
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80106ebb:	81 e1 00 f0 ff ff    	and    $0xfffff000,%ecx
  return &pgtab[PTX(va)];
80106ec1:	25 fc 0f 00 00       	and    $0xffc,%eax
80106ec6:	8d 8c 01 00 00 00 80 	lea    -0x80000000(%ecx,%eax,1),%ecx
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
80106ecd:	85 c9                	test   %ecx,%ecx
80106ecf:	74 d4                	je     80106ea5 <loaduvm+0x35>
    if(sz - i < PGSIZE)
80106ed1:	89 fb                	mov    %edi,%ebx
80106ed3:	b8 00 10 00 00       	mov    $0x1000,%eax
80106ed8:	29 f3                	sub    %esi,%ebx
80106eda:	39 c3                	cmp    %eax,%ebx
80106edc:	0f 47 d8             	cmova  %eax,%ebx
    if(readi(ip, P2V(pa), offset+i, n) != n)
80106edf:	53                   	push   %ebx
80106ee0:	8b 45 14             	mov    0x14(%ebp),%eax
80106ee3:	01 f0                	add    %esi,%eax
80106ee5:	50                   	push   %eax
    pa = PTE_ADDR(*pte);
80106ee6:	8b 01                	mov    (%ecx),%eax
80106ee8:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    if(readi(ip, P2V(pa), offset+i, n) != n)
80106eed:	05 00 00 00 80       	add    $0x80000000,%eax
80106ef2:	50                   	push   %eax
80106ef3:	ff 75 10             	push   0x10(%ebp)
80106ef6:	e8 15 ac ff ff       	call   80101b10 <readi>
80106efb:	83 c4 10             	add    $0x10,%esp
80106efe:	39 d8                	cmp    %ebx,%eax
80106f00:	75 1e                	jne    80106f20 <loaduvm+0xb0>
  for(i = 0; i < sz; i += PGSIZE){
80106f02:	81 c6 00 10 00 00    	add    $0x1000,%esi
80106f08:	39 fe                	cmp    %edi,%esi
80106f0a:	72 84                	jb     80106e90 <loaduvm+0x20>
}
80106f0c:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80106f0f:	31 c0                	xor    %eax,%eax
}
80106f11:	5b                   	pop    %ebx
80106f12:	5e                   	pop    %esi
80106f13:	5f                   	pop    %edi
80106f14:	5d                   	pop    %ebp
80106f15:	c3                   	ret
80106f16:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80106f1d:	00 
80106f1e:	66 90                	xchg   %ax,%ax
80106f20:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
80106f23:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106f28:	5b                   	pop    %ebx
80106f29:	5e                   	pop    %esi
80106f2a:	5f                   	pop    %edi
80106f2b:	5d                   	pop    %ebp
80106f2c:	c3                   	ret
    panic("loaduvm: addr must be page aligned");
80106f2d:	83 ec 0c             	sub    $0xc,%esp
80106f30:	68 e4 89 10 80       	push   $0x801089e4
80106f35:	e8 46 94 ff ff       	call   80100380 <panic>
80106f3a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80106f40 <allocuvm>:
{
80106f40:	55                   	push   %ebp
80106f41:	89 e5                	mov    %esp,%ebp
80106f43:	57                   	push   %edi
80106f44:	56                   	push   %esi
80106f45:	53                   	push   %ebx
80106f46:	83 ec 0c             	sub    $0xc,%esp
80106f49:	8b 55 10             	mov    0x10(%ebp),%edx
  if(newsz >= HEAPLIMIT) // Allocuvm can only alloc upto HEAPLIMIT
80106f4c:	81 fa ff ff ff 7e    	cmp    $0x7effffff,%edx
80106f52:	0f 87 a3 00 00 00    	ja     80106ffb <allocuvm+0xbb>
    return oldsz;
80106f58:	8b 45 0c             	mov    0xc(%ebp),%eax
  if(newsz < oldsz)
80106f5b:	3b 55 0c             	cmp    0xc(%ebp),%edx
80106f5e:	0f 82 99 00 00 00    	jb     80106ffd <allocuvm+0xbd>
  a = PGROUNDUP(oldsz);
80106f64:	05 ff 0f 00 00       	add    $0xfff,%eax
80106f69:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80106f6e:	89 c6                	mov    %eax,%esi
  for(; a < newsz; a += PGSIZE){
80106f70:	39 d0                	cmp    %edx,%eax
80106f72:	0f 83 93 00 00 00    	jae    8010700b <allocuvm+0xcb>
80106f78:	8d 4a ff             	lea    -0x1(%edx),%ecx
80106f7b:	89 55 10             	mov    %edx,0x10(%ebp)
80106f7e:	29 c1                	sub    %eax,%ecx
80106f80:	81 e1 00 f0 ff ff    	and    $0xfffff000,%ecx
80106f86:	8d bc 08 00 10 00 00 	lea    0x1000(%eax,%ecx,1),%edi
80106f8d:	eb 3e                	jmp    80106fcd <allocuvm+0x8d>
80106f8f:	90                   	nop
    memset(mem, 0, PGSIZE);
80106f90:	83 ec 04             	sub    $0x4,%esp
80106f93:	68 00 10 00 00       	push   $0x1000
80106f98:	6a 00                	push   $0x0
80106f9a:	50                   	push   %eax
80106f9b:	e8 00 d8 ff ff       	call   801047a0 <memset>
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
80106fa0:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80106fa6:	c7 04 24 06 00 00 00 	movl   $0x6,(%esp)
80106fad:	50                   	push   %eax
80106fae:	68 00 10 00 00       	push   $0x1000
80106fb3:	56                   	push   %esi
80106fb4:	ff 75 08             	push   0x8(%ebp)
80106fb7:	e8 24 fc ff ff       	call   80106be0 <mappages>
80106fbc:	83 c4 20             	add    $0x20,%esp
80106fbf:	85 c0                	test   %eax,%eax
80106fc1:	78 55                	js     80107018 <allocuvm+0xd8>
  for(; a < newsz; a += PGSIZE){
80106fc3:	81 c6 00 10 00 00    	add    $0x1000,%esi
80106fc9:	39 fe                	cmp    %edi,%esi
80106fcb:	74 3b                	je     80107008 <allocuvm+0xc8>
    mem = kalloc();
80106fcd:	e8 ee b6 ff ff       	call   801026c0 <kalloc>
80106fd2:	89 c3                	mov    %eax,%ebx
    if(mem == 0){
80106fd4:	85 c0                	test   %eax,%eax
80106fd6:	75 b8                	jne    80106f90 <allocuvm+0x50>
      cprintf("allocuvm out of memory\n");
80106fd8:	83 ec 0c             	sub    $0xc,%esp
80106fdb:	68 dd 86 10 80       	push   $0x801086dd
80106fe0:	e8 cb 96 ff ff       	call   801006b0 <cprintf>
  if(newsz >= oldsz)
80106fe5:	8b 55 10             	mov    0x10(%ebp),%edx
80106fe8:	83 c4 10             	add    $0x10,%esp
80106feb:	3b 55 0c             	cmp    0xc(%ebp),%edx
80106fee:	74 0b                	je     80106ffb <allocuvm+0xbb>
80106ff0:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80106ff3:	8b 45 08             	mov    0x8(%ebp),%eax
80106ff6:	e8 95 fa ff ff       	call   80106a90 <deallocuvm.part.0>
    return 0;
80106ffb:	31 c0                	xor    %eax,%eax
}
80106ffd:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107000:	5b                   	pop    %ebx
80107001:	5e                   	pop    %esi
80107002:	5f                   	pop    %edi
80107003:	5d                   	pop    %ebp
80107004:	c3                   	ret
80107005:	8d 76 00             	lea    0x0(%esi),%esi
80107008:	8b 55 10             	mov    0x10(%ebp),%edx
8010700b:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return newsz;
8010700e:	89 d0                	mov    %edx,%eax
}
80107010:	5b                   	pop    %ebx
80107011:	5e                   	pop    %esi
80107012:	5f                   	pop    %edi
80107013:	5d                   	pop    %ebp
80107014:	c3                   	ret
80107015:	8d 76 00             	lea    0x0(%esi),%esi
      cprintf("allocuvm out of memory (2)\n");
80107018:	83 ec 0c             	sub    $0xc,%esp
8010701b:	68 f5 86 10 80       	push   $0x801086f5
80107020:	e8 8b 96 ff ff       	call   801006b0 <cprintf>
  if(newsz >= oldsz)
80107025:	8b 55 10             	mov    0x10(%ebp),%edx
80107028:	83 c4 10             	add    $0x10,%esp
8010702b:	3b 55 0c             	cmp    0xc(%ebp),%edx
8010702e:	74 0b                	je     8010703b <allocuvm+0xfb>
80107030:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80107033:	8b 45 08             	mov    0x8(%ebp),%eax
80107036:	e8 55 fa ff ff       	call   80106a90 <deallocuvm.part.0>
      kfree(mem);
8010703b:	83 ec 0c             	sub    $0xc,%esp
8010703e:	53                   	push   %ebx
8010703f:	e8 bc b4 ff ff       	call   80102500 <kfree>
      return 0;
80107044:	83 c4 10             	add    $0x10,%esp
    return 0;
80107047:	31 c0                	xor    %eax,%eax
80107049:	eb b2                	jmp    80106ffd <allocuvm+0xbd>
8010704b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80107050 <deallocuvm>:
{
80107050:	55                   	push   %ebp
80107051:	89 e5                	mov    %esp,%ebp
80107053:	8b 55 0c             	mov    0xc(%ebp),%edx
80107056:	8b 4d 10             	mov    0x10(%ebp),%ecx
80107059:	8b 45 08             	mov    0x8(%ebp),%eax
  if(newsz >= oldsz)
8010705c:	39 d1                	cmp    %edx,%ecx
8010705e:	73 10                	jae    80107070 <deallocuvm+0x20>
}
80107060:	5d                   	pop    %ebp
80107061:	e9 2a fa ff ff       	jmp    80106a90 <deallocuvm.part.0>
80107066:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010706d:	00 
8010706e:	66 90                	xchg   %ax,%ax
80107070:	89 d0                	mov    %edx,%eax
80107072:	5d                   	pop    %ebp
80107073:	c3                   	ret
80107074:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010707b:	00 
8010707c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80107080 <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
80107080:	55                   	push   %ebp
80107081:	89 e5                	mov    %esp,%ebp
80107083:	57                   	push   %edi
80107084:	56                   	push   %esi
80107085:	53                   	push   %ebx
80107086:	83 ec 0c             	sub    $0xc,%esp
80107089:	8b 75 08             	mov    0x8(%ebp),%esi
  uint i;

  if(pgdir == 0)
8010708c:	85 f6                	test   %esi,%esi
8010708e:	74 59                	je     801070e9 <freevm+0x69>
  if(newsz >= oldsz)
80107090:	31 c9                	xor    %ecx,%ecx
80107092:	ba 00 00 00 7f       	mov    $0x7f000000,%edx
80107097:	89 f0                	mov    %esi,%eax
80107099:	89 f3                	mov    %esi,%ebx
8010709b:	e8 f0 f9 ff ff       	call   80106a90 <deallocuvm.part.0>
    panic("freevm: no pgdir");
  deallocuvm(pgdir, HEAPLIMIT, 0);
  for(i = 0; i < NPDENTRIES; i++){
801070a0:	8d be 00 10 00 00    	lea    0x1000(%esi),%edi
801070a6:	eb 0f                	jmp    801070b7 <freevm+0x37>
801070a8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801070af:	00 
801070b0:	83 c3 04             	add    $0x4,%ebx
801070b3:	39 fb                	cmp    %edi,%ebx
801070b5:	74 23                	je     801070da <freevm+0x5a>
    if(pgdir[i] & PTE_P){
801070b7:	8b 03                	mov    (%ebx),%eax
801070b9:	a8 01                	test   $0x1,%al
801070bb:	74 f3                	je     801070b0 <freevm+0x30>
      char * v = P2V(PTE_ADDR(pgdir[i]));
801070bd:	25 00 f0 ff ff       	and    $0xfffff000,%eax
      kfree(v);
801070c2:	83 ec 0c             	sub    $0xc,%esp
  for(i = 0; i < NPDENTRIES; i++){
801070c5:	83 c3 04             	add    $0x4,%ebx
      char * v = P2V(PTE_ADDR(pgdir[i]));
801070c8:	05 00 00 00 80       	add    $0x80000000,%eax
      kfree(v);
801070cd:	50                   	push   %eax
801070ce:	e8 2d b4 ff ff       	call   80102500 <kfree>
801070d3:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < NPDENTRIES; i++){
801070d6:	39 fb                	cmp    %edi,%ebx
801070d8:	75 dd                	jne    801070b7 <freevm+0x37>
    }
  }
  kfree((char*)pgdir);
801070da:	89 75 08             	mov    %esi,0x8(%ebp)
}
801070dd:	8d 65 f4             	lea    -0xc(%ebp),%esp
801070e0:	5b                   	pop    %ebx
801070e1:	5e                   	pop    %esi
801070e2:	5f                   	pop    %edi
801070e3:	5d                   	pop    %ebp
  kfree((char*)pgdir);
801070e4:	e9 17 b4 ff ff       	jmp    80102500 <kfree>
    panic("freevm: no pgdir");
801070e9:	83 ec 0c             	sub    $0xc,%esp
801070ec:	68 11 87 10 80       	push   $0x80108711
801070f1:	e8 8a 92 ff ff       	call   80100380 <panic>
801070f6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801070fd:	00 
801070fe:	66 90                	xchg   %ax,%ax

80107100 <setupkvm>:
{
80107100:	55                   	push   %ebp
80107101:	89 e5                	mov    %esp,%ebp
80107103:	56                   	push   %esi
80107104:	53                   	push   %ebx
  if((pgdir = (pde_t*)kalloc()) == 0)
80107105:	e8 b6 b5 ff ff       	call   801026c0 <kalloc>
8010710a:	85 c0                	test   %eax,%eax
8010710c:	74 5e                	je     8010716c <setupkvm+0x6c>
  memset(pgdir, 0, PGSIZE);
8010710e:	83 ec 04             	sub    $0x4,%esp
80107111:	89 c6                	mov    %eax,%esi
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80107113:	bb 20 b4 10 80       	mov    $0x8010b420,%ebx
  memset(pgdir, 0, PGSIZE);
80107118:	68 00 10 00 00       	push   $0x1000
8010711d:	6a 00                	push   $0x0
8010711f:	50                   	push   %eax
80107120:	e8 7b d6 ff ff       	call   801047a0 <memset>
80107125:	83 c4 10             	add    $0x10,%esp
                (uint)k->phys_start, k->perm) < 0) {
80107128:	8b 53 04             	mov    0x4(%ebx),%edx
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
8010712b:	83 ec 0c             	sub    $0xc,%esp
8010712e:	ff 73 0c             	push   0xc(%ebx)
80107131:	52                   	push   %edx
80107132:	8b 43 08             	mov    0x8(%ebx),%eax
80107135:	29 d0                	sub    %edx,%eax
80107137:	50                   	push   %eax
80107138:	ff 33                	push   (%ebx)
8010713a:	56                   	push   %esi
8010713b:	e8 a0 fa ff ff       	call   80106be0 <mappages>
80107140:	83 c4 20             	add    $0x20,%esp
80107143:	85 c0                	test   %eax,%eax
80107145:	78 19                	js     80107160 <setupkvm+0x60>
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80107147:	83 c3 10             	add    $0x10,%ebx
8010714a:	81 fb 60 b4 10 80    	cmp    $0x8010b460,%ebx
80107150:	75 d6                	jne    80107128 <setupkvm+0x28>
}
80107152:	8d 65 f8             	lea    -0x8(%ebp),%esp
80107155:	89 f0                	mov    %esi,%eax
80107157:	5b                   	pop    %ebx
80107158:	5e                   	pop    %esi
80107159:	5d                   	pop    %ebp
8010715a:	c3                   	ret
8010715b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
      freevm(pgdir);
80107160:	83 ec 0c             	sub    $0xc,%esp
80107163:	56                   	push   %esi
80107164:	e8 17 ff ff ff       	call   80107080 <freevm>
      return 0;
80107169:	83 c4 10             	add    $0x10,%esp
}
8010716c:	8d 65 f8             	lea    -0x8(%ebp),%esp
    return 0;
8010716f:	31 f6                	xor    %esi,%esi
}
80107171:	89 f0                	mov    %esi,%eax
80107173:	5b                   	pop    %ebx
80107174:	5e                   	pop    %esi
80107175:	5d                   	pop    %ebp
80107176:	c3                   	ret
80107177:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010717e:	00 
8010717f:	90                   	nop

80107180 <kvmalloc>:
{
80107180:	55                   	push   %ebp
80107181:	89 e5                	mov    %esp,%ebp
80107183:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
80107186:	e8 75 ff ff ff       	call   80107100 <setupkvm>
8010718b:	a3 24 d5 33 80       	mov    %eax,0x8033d524
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80107190:	05 00 00 00 80       	add    $0x80000000,%eax
80107195:	0f 22 d8             	mov    %eax,%cr3
}
80107198:	c9                   	leave
80107199:	c3                   	ret
8010719a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801071a0 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
801071a0:	55                   	push   %ebp
801071a1:	89 e5                	mov    %esp,%ebp
801071a3:	83 ec 08             	sub    $0x8,%esp
801071a6:	8b 45 0c             	mov    0xc(%ebp),%eax
  if(*pde & PTE_P){
801071a9:	8b 55 08             	mov    0x8(%ebp),%edx
  pde = &pgdir[PDX(va)];
801071ac:	89 c1                	mov    %eax,%ecx
801071ae:	c1 e9 16             	shr    $0x16,%ecx
  if(*pde & PTE_P){
801071b1:	8b 14 8a             	mov    (%edx,%ecx,4),%edx
801071b4:	f6 c2 01             	test   $0x1,%dl
801071b7:	75 17                	jne    801071d0 <clearpteu+0x30>
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
  if(pte == 0)
    panic("clearpteu");
801071b9:	83 ec 0c             	sub    $0xc,%esp
801071bc:	68 22 87 10 80       	push   $0x80108722
801071c1:	e8 ba 91 ff ff       	call   80100380 <panic>
801071c6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801071cd:	00 
801071ce:	66 90                	xchg   %ax,%ax
  return &pgtab[PTX(va)];
801071d0:	c1 e8 0a             	shr    $0xa,%eax
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
801071d3:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
  return &pgtab[PTX(va)];
801071d9:	25 fc 0f 00 00       	and    $0xffc,%eax
801071de:	8d 84 02 00 00 00 80 	lea    -0x80000000(%edx,%eax,1),%eax
  if(pte == 0)
801071e5:	85 c0                	test   %eax,%eax
801071e7:	74 d0                	je     801071b9 <clearpteu+0x19>
  *pte &= ~PTE_U;
801071e9:	83 20 fb             	andl   $0xfffffffb,(%eax)
}
801071ec:	c9                   	leave
801071ed:	c3                   	ret
801071ee:	66 90                	xchg   %ax,%ax

801071f0 <clearmapping>:

// Clear PTE_P on a page. Used to mark a mapping as invalid.
void
clearmapping(pde_t *pgdir, char *uva)
{
801071f0:	55                   	push   %ebp
801071f1:	89 e5                	mov    %esp,%ebp
801071f3:	83 ec 08             	sub    $0x8,%esp
801071f6:	8b 45 0c             	mov    0xc(%ebp),%eax
  if(*pde & PTE_P){
801071f9:	8b 55 08             	mov    0x8(%ebp),%edx
  pde = &pgdir[PDX(va)];
801071fc:	89 c1                	mov    %eax,%ecx
801071fe:	c1 e9 16             	shr    $0x16,%ecx
  if(*pde & PTE_P){
80107201:	8b 14 8a             	mov    (%edx,%ecx,4),%edx
80107204:	f6 c2 01             	test   $0x1,%dl
80107207:	75 17                	jne    80107220 <clearmapping+0x30>
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
  if(pte == 0)
    panic("clearmapping");
80107209:	83 ec 0c             	sub    $0xc,%esp
8010720c:	68 2c 87 10 80       	push   $0x8010872c
80107211:	e8 6a 91 ff ff       	call   80100380 <panic>
80107216:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010721d:	00 
8010721e:	66 90                	xchg   %ax,%ax
  return &pgtab[PTX(va)];
80107220:	c1 e8 0a             	shr    $0xa,%eax
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80107223:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
  return &pgtab[PTX(va)];
80107229:	25 fc 0f 00 00       	and    $0xffc,%eax
8010722e:	8d 84 02 00 00 00 80 	lea    -0x80000000(%edx,%eax,1),%eax
  if(pte == 0)
80107235:	85 c0                	test   %eax,%eax
80107237:	74 d0                	je     80107209 <clearmapping+0x19>
  *pte &= ~PTE_P;
80107239:	83 20 fe             	andl   $0xfffffffe,(%eax)
}
8010723c:	c9                   	leave
8010723d:	c3                   	ret
8010723e:	66 90                	xchg   %ax,%ax

80107240 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
80107240:	55                   	push   %ebp
80107241:	89 e5                	mov    %esp,%ebp
80107243:	57                   	push   %edi
80107244:	56                   	push   %esi
80107245:	53                   	push   %ebx
80107246:	83 ec 1c             	sub    $0x1c,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
80107249:	e8 b2 fe ff ff       	call   80107100 <setupkvm>
8010724e:	89 45 e0             	mov    %eax,-0x20(%ebp)
80107251:	85 c0                	test   %eax,%eax
80107253:	0f 84 e9 00 00 00    	je     80107342 <copyuvm+0x102>
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
80107259:	8b 55 0c             	mov    0xc(%ebp),%edx
8010725c:	85 d2                	test   %edx,%edx
8010725e:	0f 84 b5 00 00 00    	je     80107319 <copyuvm+0xd9>
80107264:	31 f6                	xor    %esi,%esi
80107266:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010726d:	00 
8010726e:	66 90                	xchg   %ax,%ax
  if(*pde & PTE_P){
80107270:	8b 4d 08             	mov    0x8(%ebp),%ecx
  pde = &pgdir[PDX(va)];
80107273:	89 f0                	mov    %esi,%eax
80107275:	c1 e8 16             	shr    $0x16,%eax
  if(*pde & PTE_P){
80107278:	8b 04 81             	mov    (%ecx,%eax,4),%eax
8010727b:	a8 01                	test   $0x1,%al
8010727d:	75 11                	jne    80107290 <copyuvm+0x50>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
      panic("copyuvm: pte should exist");
8010727f:	83 ec 0c             	sub    $0xc,%esp
80107282:	68 39 87 10 80       	push   $0x80108739
80107287:	e8 f4 90 ff ff       	call   80100380 <panic>
8010728c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  return &pgtab[PTX(va)];
80107290:	89 f2                	mov    %esi,%edx
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80107292:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  return &pgtab[PTX(va)];
80107297:	c1 ea 0a             	shr    $0xa,%edx
8010729a:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
801072a0:	8d 84 10 00 00 00 80 	lea    -0x80000000(%eax,%edx,1),%eax
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
801072a7:	85 c0                	test   %eax,%eax
801072a9:	74 d4                	je     8010727f <copyuvm+0x3f>
    if(!(*pte & PTE_P))
801072ab:	8b 38                	mov    (%eax),%edi
801072ad:	f7 c7 01 00 00 00    	test   $0x1,%edi
801072b3:	0f 84 9b 00 00 00    	je     80107354 <copyuvm+0x114>
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
801072b9:	89 fb                	mov    %edi,%ebx
    flags = PTE_FLAGS(*pte);
801072bb:	81 e7 ff 0f 00 00    	and    $0xfff,%edi
801072c1:	89 7d e4             	mov    %edi,-0x1c(%ebp)
    pa = PTE_ADDR(*pte);
801072c4:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
    if((mem = kalloc()) == 0)
801072ca:	e8 f1 b3 ff ff       	call   801026c0 <kalloc>
801072cf:	89 c7                	mov    %eax,%edi
801072d1:	85 c0                	test   %eax,%eax
801072d3:	74 5f                	je     80107334 <copyuvm+0xf4>
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
801072d5:	83 ec 04             	sub    $0x4,%esp
801072d8:	81 c3 00 00 00 80    	add    $0x80000000,%ebx
801072de:	68 00 10 00 00       	push   $0x1000
801072e3:	53                   	push   %ebx
801072e4:	50                   	push   %eax
801072e5:	e8 46 d5 ff ff       	call   80104830 <memmove>
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0) {
801072ea:	58                   	pop    %eax
801072eb:	8d 87 00 00 00 80    	lea    -0x80000000(%edi),%eax
801072f1:	ff 75 e4             	push   -0x1c(%ebp)
801072f4:	50                   	push   %eax
801072f5:	68 00 10 00 00       	push   $0x1000
801072fa:	56                   	push   %esi
801072fb:	ff 75 e0             	push   -0x20(%ebp)
801072fe:	e8 dd f8 ff ff       	call   80106be0 <mappages>
80107303:	83 c4 20             	add    $0x20,%esp
80107306:	85 c0                	test   %eax,%eax
80107308:	78 1e                	js     80107328 <copyuvm+0xe8>
  for(i = 0; i < sz; i += PGSIZE){
8010730a:	81 c6 00 10 00 00    	add    $0x1000,%esi
80107310:	3b 75 0c             	cmp    0xc(%ebp),%esi
80107313:	0f 82 57 ff ff ff    	jb     80107270 <copyuvm+0x30>
  return d;

bad:
  freevm(d);
  return 0;
}
80107319:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010731c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010731f:	5b                   	pop    %ebx
80107320:	5e                   	pop    %esi
80107321:	5f                   	pop    %edi
80107322:	5d                   	pop    %ebp
80107323:	c3                   	ret
80107324:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      kfree(mem);
80107328:	83 ec 0c             	sub    $0xc,%esp
8010732b:	57                   	push   %edi
8010732c:	e8 cf b1 ff ff       	call   80102500 <kfree>
      goto bad;
80107331:	83 c4 10             	add    $0x10,%esp
  freevm(d);
80107334:	83 ec 0c             	sub    $0xc,%esp
80107337:	ff 75 e0             	push   -0x20(%ebp)
8010733a:	e8 41 fd ff ff       	call   80107080 <freevm>
  return 0;
8010733f:	83 c4 10             	add    $0x10,%esp
    return 0;
80107342:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
}
80107349:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010734c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010734f:	5b                   	pop    %ebx
80107350:	5e                   	pop    %esi
80107351:	5f                   	pop    %edi
80107352:	5d                   	pop    %ebp
80107353:	c3                   	ret
      panic("copyuvm: page not present");
80107354:	83 ec 0c             	sub    $0xc,%esp
80107357:	68 53 87 10 80       	push   $0x80108753
8010735c:	e8 1f 90 ff ff       	call   80100380 <panic>
80107361:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80107368:	00 
80107369:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80107370 <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
80107370:	55                   	push   %ebp
80107371:	89 e5                	mov    %esp,%ebp
80107373:	8b 45 0c             	mov    0xc(%ebp),%eax
  if(*pde & PTE_P){
80107376:	8b 55 08             	mov    0x8(%ebp),%edx
  pde = &pgdir[PDX(va)];
80107379:	89 c1                	mov    %eax,%ecx
8010737b:	c1 e9 16             	shr    $0x16,%ecx
  if(*pde & PTE_P){
8010737e:	8b 14 8a             	mov    (%edx,%ecx,4),%edx
80107381:	f6 c2 01             	test   $0x1,%dl
80107384:	0f 84 f8 00 00 00    	je     80107482 <uva2ka.cold>
  return &pgtab[PTX(va)];
8010738a:	c1 e8 0c             	shr    $0xc,%eax
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
8010738d:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
  if((*pte & PTE_P) == 0)
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
}
80107393:	5d                   	pop    %ebp
  return &pgtab[PTX(va)];
80107394:	25 ff 03 00 00       	and    $0x3ff,%eax
  if((*pte & PTE_P) == 0)
80107399:	8b 94 82 00 00 00 80 	mov    -0x80000000(%edx,%eax,4),%edx
  return (char*)P2V(PTE_ADDR(*pte));
801073a0:	89 d0                	mov    %edx,%eax
801073a2:	f7 d2                	not    %edx
801073a4:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801073a9:	05 00 00 00 80       	add    $0x80000000,%eax
801073ae:	83 e2 05             	and    $0x5,%edx
801073b1:	ba 00 00 00 00       	mov    $0x0,%edx
801073b6:	0f 45 c2             	cmovne %edx,%eax
}
801073b9:	c3                   	ret
801073ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801073c0 <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
801073c0:	55                   	push   %ebp
801073c1:	89 e5                	mov    %esp,%ebp
801073c3:	57                   	push   %edi
801073c4:	56                   	push   %esi
801073c5:	53                   	push   %ebx
801073c6:	83 ec 0c             	sub    $0xc,%esp
801073c9:	8b 75 14             	mov    0x14(%ebp),%esi
801073cc:	8b 45 0c             	mov    0xc(%ebp),%eax
801073cf:	8b 55 10             	mov    0x10(%ebp),%edx
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
801073d2:	85 f6                	test   %esi,%esi
801073d4:	75 51                	jne    80107427 <copyout+0x67>
801073d6:	e9 9d 00 00 00       	jmp    80107478 <copyout+0xb8>
801073db:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  return (char*)P2V(PTE_ADDR(*pte));
801073e0:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
801073e6:	8d 8b 00 00 00 80    	lea    -0x80000000(%ebx),%ecx
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
801073ec:	81 fb 00 00 00 80    	cmp    $0x80000000,%ebx
801073f2:	74 74                	je     80107468 <copyout+0xa8>
      return -1;
    n = PGSIZE - (va - va0);
801073f4:	89 fb                	mov    %edi,%ebx
801073f6:	29 c3                	sub    %eax,%ebx
801073f8:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    if(n > len)
801073fe:	39 f3                	cmp    %esi,%ebx
80107400:	0f 47 de             	cmova  %esi,%ebx
      n = len;
    memmove(pa0 + (va - va0), buf, n);
80107403:	29 f8                	sub    %edi,%eax
80107405:	83 ec 04             	sub    $0x4,%esp
80107408:	01 c1                	add    %eax,%ecx
8010740a:	53                   	push   %ebx
8010740b:	52                   	push   %edx
8010740c:	89 55 10             	mov    %edx,0x10(%ebp)
8010740f:	51                   	push   %ecx
80107410:	e8 1b d4 ff ff       	call   80104830 <memmove>
    len -= n;
    buf += n;
80107415:	8b 55 10             	mov    0x10(%ebp),%edx
    va = va0 + PGSIZE;
80107418:	8d 87 00 10 00 00    	lea    0x1000(%edi),%eax
  while(len > 0){
8010741e:	83 c4 10             	add    $0x10,%esp
    buf += n;
80107421:	01 da                	add    %ebx,%edx
  while(len > 0){
80107423:	29 de                	sub    %ebx,%esi
80107425:	74 51                	je     80107478 <copyout+0xb8>
  if(*pde & PTE_P){
80107427:	8b 5d 08             	mov    0x8(%ebp),%ebx
  pde = &pgdir[PDX(va)];
8010742a:	89 c1                	mov    %eax,%ecx
    va0 = (uint)PGROUNDDOWN(va);
8010742c:	89 c7                	mov    %eax,%edi
  pde = &pgdir[PDX(va)];
8010742e:	c1 e9 16             	shr    $0x16,%ecx
    va0 = (uint)PGROUNDDOWN(va);
80107431:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
  if(*pde & PTE_P){
80107437:	8b 0c 8b             	mov    (%ebx,%ecx,4),%ecx
8010743a:	f6 c1 01             	test   $0x1,%cl
8010743d:	0f 84 46 00 00 00    	je     80107489 <copyout.cold>
  return &pgtab[PTX(va)];
80107443:	89 fb                	mov    %edi,%ebx
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80107445:	81 e1 00 f0 ff ff    	and    $0xfffff000,%ecx
  return &pgtab[PTX(va)];
8010744b:	c1 eb 0c             	shr    $0xc,%ebx
8010744e:	81 e3 ff 03 00 00    	and    $0x3ff,%ebx
  if((*pte & PTE_P) == 0)
80107454:	8b 9c 99 00 00 00 80 	mov    -0x80000000(%ecx,%ebx,4),%ebx
  if((*pte & PTE_U) == 0)
8010745b:	89 d9                	mov    %ebx,%ecx
8010745d:	f7 d1                	not    %ecx
8010745f:	83 e1 05             	and    $0x5,%ecx
80107462:	0f 84 78 ff ff ff    	je     801073e0 <copyout+0x20>
  }
  return 0;
}
80107468:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
8010746b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80107470:	5b                   	pop    %ebx
80107471:	5e                   	pop    %esi
80107472:	5f                   	pop    %edi
80107473:	5d                   	pop    %ebp
80107474:	c3                   	ret
80107475:	8d 76 00             	lea    0x0(%esi),%esi
80107478:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
8010747b:	31 c0                	xor    %eax,%eax
}
8010747d:	5b                   	pop    %ebx
8010747e:	5e                   	pop    %esi
8010747f:	5f                   	pop    %edi
80107480:	5d                   	pop    %ebp
80107481:	c3                   	ret

80107482 <uva2ka.cold>:
  if((*pte & PTE_P) == 0)
80107482:	a1 00 00 00 00       	mov    0x0,%eax
80107487:	0f 0b                	ud2

80107489 <copyout.cold>:
80107489:	a1 00 00 00 00       	mov    0x0,%eax
8010748e:	0f 0b                	ud2

80107490 <shminit>:
#include "elf.h"
#include "spinlock.h"
#include "shm.h"
#include "date.h"

void shminit(){
80107490:	55                   	push   %ebp
80107491:	89 e5                	mov    %esp,%ebp
80107493:	83 ec 10             	sub    $0x10,%esp
	initlock(&shmpgtable.lock, "shmpgtable");
80107496:	68 6d 87 10 80       	push   $0x8010876d
8010749b:	68 80 b4 10 80       	push   $0x8010b480
801074a0:	e8 0b d0 ff ff       	call   801044b0 <initlock>
}
801074a5:	83 c4 10             	add    $0x10,%esp
801074a8:	c9                   	leave
801074a9:	c3                   	ret
801074aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801074b0 <generate_random_key>:

struct rtcdate r;

uint generate_random_key() {
801074b0:	55                   	push   %ebp
801074b1:	89 e5                	mov    %esp,%ebp
801074b3:	83 ec 14             	sub    $0x14,%esp
	cmostime(&r);	
801074b6:	68 28 d5 33 80       	push   $0x8033d528
801074bb:	e8 50 b5 ff ff       	call   80102a10 <cmostime>
	uint key =  r.second * 10000 + r.minute * 100 + r.hour * 10 + r.day + ticks;
801074c0:	a1 c0 cc 33 80       	mov    0x8033ccc0,%eax
801074c5:	69 15 28 d5 33 80 10 	imul   $0x2710,0x8033d528,%edx
801074cc:	27 00 00 
801074cf:	03 05 34 d5 33 80    	add    0x8033d534,%eax
801074d5:	01 d0                	add    %edx,%eax
801074d7:	6b 15 2c d5 33 80 64 	imul   $0x64,0x8033d52c,%edx
801074de:	01 d0                	add    %edx,%eax
801074e0:	8b 15 30 d5 33 80    	mov    0x8033d530,%edx
	return key;
}
801074e6:	c9                   	leave
	uint key =  r.second * 10000 + r.minute * 100 + r.hour * 10 + r.day + ticks;
801074e7:	8d 14 92             	lea    (%edx,%edx,4),%edx
801074ea:	8d 04 50             	lea    (%eax,%edx,2),%eax
}
801074ed:	c3                   	ret
801074ee:	66 90                	xchg   %ax,%ax

801074f0 <updateShmSeg>:

//Update the segment due to  forked child process
// flag = 0 ==> called through forkS
// flag = 1 ==> called through exec
void updateShmSeg(int shmid, int pid, int flag){
801074f0:	55                   	push   %ebp
801074f1:	89 e5                	mov    %esp,%ebp
801074f3:	57                   	push   %edi
801074f4:	56                   	push   %esi
801074f5:	53                   	push   %ebx
801074f6:	83 ec 28             	sub    $0x28,%esp
801074f9:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801074fc:	8b 55 10             	mov    0x10(%ebp),%edx
801074ff:	8b 75 08             	mov    0x8(%ebp),%esi
80107502:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80107505:	89 55 e4             	mov    %edx,-0x1c(%ebp)
	cmostime(&r);
80107508:	68 28 d5 33 80       	push   $0x8033d528
8010750d:	e8 fe b4 ff ff       	call   80102a10 <cmostime>
	int reqPages = shmpgtable.shm_segs[shmid].shm_segsz / PGSIZE;
80107512:	8d 04 b6             	lea    (%esi,%esi,4),%eax
80107515:	c1 e0 03             	shl    $0x3,%eax
80107518:	8d 98 80 b4 10 80    	lea    -0x7fef4b80(%eax),%ebx
8010751e:	89 45 dc             	mov    %eax,-0x24(%ebp)
80107521:	8b 7b 3c             	mov    0x3c(%ebx),%edi
	acquire(&shmpgtable.lock);
80107524:	c7 04 24 80 b4 10 80 	movl   $0x8010b480,(%esp)
	int reqPages = shmpgtable.shm_segs[shmid].shm_segsz / PGSIZE;
8010752b:	c1 ef 0c             	shr    $0xc,%edi
	acquire(&shmpgtable.lock);
8010752e:	e8 6d d1 ff ff       	call   801046a0 <acquire>
	if (flag == 0){
80107533:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80107536:	83 c4 10             	add    $0x10,%esp
80107539:	8b 4d e0             	mov    -0x20(%ebp),%ecx
8010753c:	85 d2                	test   %edx,%edx
8010753e:	74 60                	je     801075a0 <updateShmSeg+0xb0>
			shmpgtable.shm_segs[shmid + i].shm_lpid = pid;
			shmpgtable.shm_segs[shmid + i].shm_atime = r.hour*10000+r.minute*100+r.second;	
		}
	}
	else{
		for(int i = 0; i < reqPages; i++){
80107540:	85 ff                	test   %edi,%edi
80107542:	8b 45 dc             	mov    -0x24(%ebp),%eax
80107545:	74 3d                	je     80107584 <updateShmSeg+0x94>
			shmpgtable.shm_segs[shmid + i].shm_nattch -= 1;
			shmpgtable.shm_segs[shmid + i].shm_dtime = r.hour*10000+r.minute*100+r.second;	
80107547:	6b 0d 2c d5 33 80 64 	imul   $0x64,0x8033d52c,%ecx
8010754e:	01 f7                	add    %esi,%edi
80107550:	69 15 30 d5 33 80 10 	imul   $0x2710,0x8033d530,%edx
80107557:	27 00 00 
8010755a:	01 ca                	add    %ecx,%edx
8010755c:	8d 0c bf             	lea    (%edi,%edi,4),%ecx
8010755f:	03 15 28 d5 33 80    	add    0x8033d528,%edx
80107565:	c1 e1 03             	shl    $0x3,%ecx
80107568:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010756f:	00 
			shmpgtable.shm_segs[shmid + i].shm_nattch -= 1;
80107570:	83 a8 d4 b4 10 80 01 	subl   $0x1,-0x7fef4b2c(%eax)
		for(int i = 0; i < reqPages; i++){
80107577:	83 c0 28             	add    $0x28,%eax
			shmpgtable.shm_segs[shmid + i].shm_dtime = r.hour*10000+r.minute*100+r.second;	
8010757a:	89 90 9c b4 10 80    	mov    %edx,-0x7fef4b64(%eax)
		for(int i = 0; i < reqPages; i++){
80107580:	39 c8                	cmp    %ecx,%eax
80107582:	75 ec                	jne    80107570 <updateShmSeg+0x80>
		}
	}
	release(&shmpgtable.lock);
80107584:	c7 45 08 80 b4 10 80 	movl   $0x8010b480,0x8(%ebp)
}
8010758b:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010758e:	5b                   	pop    %ebx
8010758f:	5e                   	pop    %esi
80107590:	5f                   	pop    %edi
80107591:	5d                   	pop    %ebp
	release(&shmpgtable.lock);
80107592:	e9 a9 d0 ff ff       	jmp    80104640 <release>
80107597:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010759e:	00 
8010759f:	90                   	nop
		for(int i = 0; i < reqPages; i++){
801075a0:	85 ff                	test   %edi,%edi
801075a2:	74 e0                	je     80107584 <updateShmSeg+0x94>
			shmpgtable.shm_segs[shmid + i].shm_atime = r.hour*10000+r.minute*100+r.second;	
801075a4:	6b 05 2c d5 33 80 64 	imul   $0x64,0x8033d52c,%eax
801075ab:	01 f7                	add    %esi,%edi
801075ad:	69 15 30 d5 33 80 10 	imul   $0x2710,0x8033d530,%edx
801075b4:	27 00 00 
801075b7:	01 c2                	add    %eax,%edx
801075b9:	89 d8                	mov    %ebx,%eax
801075bb:	8d 1c bf             	lea    (%edi,%edi,4),%ebx
801075be:	03 15 28 d5 33 80    	add    0x8033d528,%edx
801075c4:	8d 1c dd 80 b4 10 80 	lea    -0x7fef4b80(,%ebx,8),%ebx
801075cb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
			shmpgtable.shm_segs[shmid + i].shm_nattch += 1;
801075d0:	83 40 54 01          	addl   $0x1,0x54(%eax)
		for(int i = 0; i < reqPages; i++){
801075d4:	83 c0 28             	add    $0x28,%eax
			shmpgtable.shm_segs[shmid + i].shm_lpid = pid;
801075d7:	89 48 28             	mov    %ecx,0x28(%eax)
			shmpgtable.shm_segs[shmid + i].shm_atime = r.hour*10000+r.minute*100+r.second;	
801075da:	89 50 18             	mov    %edx,0x18(%eax)
		for(int i = 0; i < reqPages; i++){
801075dd:	39 d8                	cmp    %ebx,%eax
801075df:	75 ef                	jne    801075d0 <updateShmSeg+0xe0>
801075e1:	eb a1                	jmp    80107584 <updateShmSeg+0x94>
801075e3:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801075ea:	00 
801075eb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

801075f0 <mapShmSegPage>:

// Adds physical address pa of the page of shm segment into shm_segs array at lastShmSegIndex + 1
int mapShmSegPage(struct shmpgtable *shmpagetable, uint pa, int key, int segSize, int index, int pid, int perm){
801075f0:	55                   	push   %ebp
801075f1:	89 e5                	mov    %esp,%ebp
801075f3:	56                   	push   %esi
801075f4:	53                   	push   %ebx
801075f5:	8b 75 08             	mov    0x8(%ebp),%esi
801075f8:	8b 5d 18             	mov    0x18(%ebp),%ebx
	acquire(&shmpagetable->lock);
801075fb:	83 ec 0c             	sub    $0xc,%esp
801075fe:	56                   	push   %esi
801075ff:	e8 9c d0 ff ff       	call   801046a0 <acquire>
	shmpgtable.shm_segs[index].pa = (void *)pa;
80107604:	8b 55 0c             	mov    0xc(%ebp),%edx
80107607:	8d 04 9b             	lea    (%ebx,%ebx,4),%eax
8010760a:	8d 04 c5 80 b4 10 80 	lea    -0x7fef4b80(,%eax,8),%eax
80107611:	89 50 58             	mov    %edx,0x58(%eax)
	shmpgtable.shm_segs[index].shm_perm.__key = key;
80107614:	8b 55 10             	mov    0x10(%ebp),%edx
	shmpgtable.shm_segs[index].shm_perm.mode = perm;
	shmpgtable.shm_segs[index].shm_segsz = segSize;
	shmpgtable.shm_segs[index].shm_lpid = pid;
	// null other fields
	shmpgtable.shm_segs[index].shm_atime = -1;
80107617:	c7 40 40 ff ff ff ff 	movl   $0xffffffff,0x40(%eax)
	shmpgtable.shm_segs[index].shm_perm.__key = key;
8010761e:	89 50 34             	mov    %edx,0x34(%eax)
	shmpgtable.shm_segs[index].shm_perm.mode = perm;
80107621:	8b 55 20             	mov    0x20(%ebp),%edx
	shmpgtable.shm_segs[index].shm_dtime = -1;
80107624:	c7 40 44 ff ff ff ff 	movl   $0xffffffff,0x44(%eax)
	shmpgtable.shm_segs[index].shm_perm.mode = perm;
8010762b:	89 50 38             	mov    %edx,0x38(%eax)
	shmpgtable.shm_segs[index].shm_segsz = segSize;
8010762e:	8b 55 14             	mov    0x14(%ebp),%edx
	shmpgtable.shm_segs[index].shm_ctime = -1;
80107631:	c7 40 48 ff ff ff ff 	movl   $0xffffffff,0x48(%eax)
	shmpgtable.shm_segs[index].shm_segsz = segSize;
80107638:	89 50 3c             	mov    %edx,0x3c(%eax)
	shmpgtable.shm_segs[index].shm_lpid = pid;
8010763b:	8b 55 1c             	mov    0x1c(%ebp),%edx
	shmpgtable.shm_segs[index].shm_cpid = -1;
8010763e:	c7 40 4c ff ff ff ff 	movl   $0xffffffff,0x4c(%eax)
	shmpgtable.shm_segs[index].shm_lpid = pid;
80107645:	89 50 50             	mov    %edx,0x50(%eax)
	shmpgtable.shm_segs[index].shm_nattch = 0;
80107648:	c7 40 54 00 00 00 00 	movl   $0x0,0x54(%eax)
	release(&shmpagetable->lock);
8010764f:	89 34 24             	mov    %esi,(%esp)
80107652:	e8 e9 cf ff ff       	call   80104640 <release>
	return index;
}
80107657:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010765a:	89 d8                	mov    %ebx,%eax
8010765c:	5b                   	pop    %ebx
8010765d:	5e                   	pop    %esi
8010765e:	5d                   	pop    %ebp
8010765f:	c3                   	ret

80107660 <unmapShmSegPage>:

// Removes physical address stored in shm_segs array for the range of indices corresponding to allocated shm segment pages
// Called only if kalloc fails in between allocating pages for shm segment
void unmapShmSegPage(struct shmpgtable *shmpagetable, uint endIndex){
80107660:	55                   	push   %ebp
80107661:	89 e5                	mov    %esp,%ebp
80107663:	56                   	push   %esi
80107664:	53                   	push   %ebx
80107665:	8b 75 08             	mov    0x8(%ebp),%esi
80107668:	8b 5d 0c             	mov    0xc(%ebp),%ebx
	acquire(&shmpagetable->lock);
8010766b:	83 ec 0c             	sub    $0xc,%esp
8010766e:	56                   	push   %esi
8010766f:	e8 2c d0 ff ff       	call   801046a0 <acquire>
	while(endIndex != shmpgtable.lastShmSegIndex){
80107674:	8b 15 b4 34 13 80    	mov    0x801334b4,%edx
8010767a:	83 c4 10             	add    $0x10,%esp
8010767d:	39 d3                	cmp    %edx,%ebx
8010767f:	74 3a                	je     801076bb <unmapShmSegPage+0x5b>
80107681:	8d 04 9b             	lea    (%ebx,%ebx,4),%eax
80107684:	8d 14 92             	lea    (%edx,%edx,4),%edx
80107687:	8d 04 c5 b4 b4 10 80 	lea    -0x7fef4b4c(,%eax,8),%eax
8010768e:	8d 14 d5 b4 b4 10 80 	lea    -0x7fef4b4c(,%edx,8),%edx
80107695:	8d 76 00             	lea    0x0(%esi),%esi
		shmpgtable.shm_segs[endIndex].pa = 0;
80107698:	c7 40 24 00 00 00 00 	movl   $0x0,0x24(%eax)
	while(endIndex != shmpgtable.lastShmSegIndex){
8010769f:	83 e8 28             	sub    $0x28,%eax
		shmpgtable.shm_segs[endIndex].shm_perm.__key = -1;
801076a2:	c7 40 28 ff ff ff ff 	movl   $0xffffffff,0x28(%eax)
		shmpgtable.shm_segs[endIndex].shm_segsz = 0;
801076a9:	c7 40 30 00 00 00 00 	movl   $0x0,0x30(%eax)
		shmpgtable.shm_segs[endIndex].shm_perm.mode = 0;
801076b0:	c7 40 2c 00 00 00 00 	movl   $0x0,0x2c(%eax)
	while(endIndex != shmpgtable.lastShmSegIndex){
801076b7:	39 d0                	cmp    %edx,%eax
801076b9:	75 dd                	jne    80107698 <unmapShmSegPage+0x38>
		endIndex--;
	}
	release(&shmpagetable->lock);
801076bb:	89 75 08             	mov    %esi,0x8(%ebp)
}
801076be:	8d 65 f8             	lea    -0x8(%ebp),%esp
801076c1:	5b                   	pop    %ebx
801076c2:	5e                   	pop    %esi
801076c3:	5d                   	pop    %ebp
	release(&shmpagetable->lock);
801076c4:	e9 77 cf ff ff       	jmp    80104640 <release>
801076c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801076d0 <allocShmSeg>:

// Allocate pages for shmget. Return -1 on error.
int allocShmSeg(uint segmentSize, int key, int shmflag){
801076d0:	55                   	push   %ebp
801076d1:	89 e5                	mov    %esp,%ebp
801076d3:	57                   	push   %edi
801076d4:	56                   	push   %esi
801076d5:	53                   	push   %ebx
801076d6:	83 ec 2c             	sub    $0x2c,%esp
801076d9:	8b 5d 08             	mov    0x8(%ebp),%ebx
        if(segmentSize < SHMMIN || segmentSize > MAXSEGSIZE){
801076dc:	8d 83 00 fc ff ff    	lea    -0x400(%ebx),%eax
801076e2:	3d 00 fc ff 00       	cmp    $0xfffc00,%eax
801076e7:	0f 87 d1 01 00 00    	ja     801078be <allocShmSeg+0x1ee>
                return EINVAL;
        }
		struct proc *process = myproc();
801076ed:	e8 de c2 ff ff       	call   801039d0 <myproc>

        uint roundedSegSize, a = 0;
        char *mem;
		int incrementLastIndex = 0;

        roundedSegSize = PGROUNDUP(segmentSize);
801076f2:	81 c3 ff 0f 00 00    	add    $0xfff,%ebx

		// find suitable space to create a new segment
		int index = -1;
		int zc = 0;
		int si = -1;
801076f8:	ba ff ff ff ff       	mov    $0xffffffff,%edx

		int reqPages = roundedSegSize / PGSIZE;

		for(int i = 0; i <= shmpgtable.lastShmSegIndex; i++){
801076fd:	8b 3d b4 34 13 80    	mov    0x801334b4,%edi
		struct proc *process = myproc();
80107703:	89 45 e0             	mov    %eax,-0x20(%ebp)
        roundedSegSize = PGROUNDUP(segmentSize);
80107706:	89 d8                	mov    %ebx,%eax
		int reqPages = roundedSegSize / PGSIZE;
80107708:	c1 eb 0c             	shr    $0xc,%ebx
        roundedSegSize = PGROUNDUP(segmentSize);
8010770b:	25 00 f0 ff ff       	and    $0xfffff000,%eax
		int reqPages = roundedSegSize / PGSIZE;
80107710:	89 5d dc             	mov    %ebx,-0x24(%ebp)
		int zc = 0;
80107713:	31 db                	xor    %ebx,%ebx
80107715:	8b 75 dc             	mov    -0x24(%ebp),%esi
        roundedSegSize = PGROUNDUP(segmentSize);
80107718:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		for(int i = 0; i <= shmpgtable.lastShmSegIndex; i++){
8010771b:	31 c0                	xor    %eax,%eax
8010771d:	85 ff                	test   %edi,%edi
8010771f:	79 21                	jns    80107742 <allocShmSeg+0x72>
80107721:	e9 89 01 00 00       	jmp    801078af <allocShmSeg+0x1df>
80107726:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010772d:	00 
8010772e:	66 90                	xchg   %ax,%ax
					index = si;
					break;
				}
			}
			else{
				si = -1;
80107730:	ba ff ff ff ff       	mov    $0xffffffff,%edx
				zc = 0;
80107735:	31 db                	xor    %ebx,%ebx
		for(int i = 0; i <= shmpgtable.lastShmSegIndex; i++){
80107737:	83 c0 01             	add    $0x1,%eax
8010773a:	39 f8                	cmp    %edi,%eax
8010773c:	0f 8f 5e 01 00 00    	jg     801078a0 <allocShmSeg+0x1d0>
			if(shmpgtable.shm_segs[i].shm_perm.__key == -1){
80107742:	8d 0c 80             	lea    (%eax,%eax,4),%ecx
80107745:	83 3c cd b4 b4 10 80 	cmpl   $0xffffffff,-0x7fef4b4c(,%ecx,8)
8010774c:	ff 
8010774d:	75 e1                	jne    80107730 <allocShmSeg+0x60>
					si = i;
8010774f:	83 fa ff             	cmp    $0xffffffff,%edx
80107752:	0f 44 d0             	cmove  %eax,%edx
				zc++;
80107755:	83 c3 01             	add    $0x1,%ebx
				if(zc == reqPages){
80107758:	39 de                	cmp    %ebx,%esi
8010775a:	75 db                	jne    80107737 <allocShmSeg+0x67>
		int incrementLastIndex = 0;
8010775c:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)
		if(index == -1){
			index = shmpgtable.lastShmSegIndex + 1;
			incrementLastIndex = 1;
		}

		if(index + reqPages > SHMMAXSEG){
80107763:	8b 45 dc             	mov    -0x24(%ebp),%eax
80107766:	01 d0                	add    %edx,%eax
80107768:	3d 00 10 00 00       	cmp    $0x1000,%eax
8010776d:	0f 8f 52 01 00 00    	jg     801078c5 <allocShmSeg+0x1f5>
                      unmapShmSegPage(&shmpgtable, (a/PGSIZE));
                      return -1;
                }
                memset(mem, 0, PGSIZE);

                mapShmSegPage(&shmpgtable, V2P(mem), key, roundedSegSize, index, process->pid, (shmflag & 03));
80107773:	8b 45 10             	mov    0x10(%ebp),%eax
80107776:	89 55 d4             	mov    %edx,-0x2c(%ebp)
			incrementLastIndex = 1;
80107779:	89 d7                	mov    %edx,%edi
        uint roundedSegSize, a = 0;
8010777b:	31 db                	xor    %ebx,%ebx
                mapShmSegPage(&shmpgtable, V2P(mem), key, roundedSegSize, index, process->pid, (shmflag & 03));
8010777d:	83 e0 03             	and    $0x3,%eax
80107780:	89 45 dc             	mov    %eax,-0x24(%ebp)
80107783:	eb 5a                	jmp    801077df <allocShmSeg+0x10f>
80107785:	8d 76 00             	lea    0x0(%esi),%esi
                memset(mem, 0, PGSIZE);
80107788:	83 ec 04             	sub    $0x4,%esp
8010778b:	68 00 10 00 00       	push   $0x1000
80107790:	6a 00                	push   $0x0
80107792:	50                   	push   %eax
80107793:	e8 08 d0 ff ff       	call   801047a0 <memset>
                mapShmSegPage(&shmpgtable, V2P(mem), key, roundedSegSize, index, process->pid, (shmflag & 03));
80107798:	83 c4 0c             	add    $0xc,%esp
8010779b:	ff 75 dc             	push   -0x24(%ebp)
8010779e:	8b 45 e0             	mov    -0x20(%ebp),%eax
801077a1:	8d 96 00 00 00 80    	lea    -0x80000000(%esi),%edx
801077a7:	ff 70 10             	push   0x10(%eax)
801077aa:	57                   	push   %edi
801077ab:	ff 75 e4             	push   -0x1c(%ebp)
801077ae:	ff 75 0c             	push   0xc(%ebp)
801077b1:	52                   	push   %edx
801077b2:	68 80 b4 10 80       	push   $0x8010b480
801077b7:	e8 34 fe ff ff       	call   801075f0 <mapShmSegPage>

		if(incrementLastIndex){
801077bc:	8b 45 d8             	mov    -0x28(%ebp),%eax
801077bf:	83 c4 20             	add    $0x20,%esp
801077c2:	85 c0                	test   %eax,%eax
801077c4:	74 07                	je     801077cd <allocShmSeg+0xfd>
			shmpgtable.lastShmSegIndex += 1;
801077c6:	83 05 b4 34 13 80 01 	addl   $0x1,0x801334b4
		}
		index++;
801077cd:	83 c7 01             	add    $0x1,%edi
                a += PGSIZE;
801077d0:	81 c3 00 10 00 00    	add    $0x1000,%ebx
        while(a != roundedSegSize){
801077d6:	39 5d e4             	cmp    %ebx,-0x1c(%ebp)
801077d9:	0f 84 99 00 00 00    	je     80107878 <allocShmSeg+0x1a8>
                mem = kalloc();
801077df:	e8 dc ae ff ff       	call   801026c0 <kalloc>
801077e4:	89 c6                	mov    %eax,%esi
                if(mem == 0){
801077e6:	85 c0                	test   %eax,%eax
801077e8:	75 9e                	jne    80107788 <allocShmSeg+0xb8>
                      cprintf("allocuvm out of memory\n");
801077ea:	83 ec 0c             	sub    $0xc,%esp
                      unmapShmSegPage(&shmpgtable, (a/PGSIZE));
801077ed:	c1 eb 0c             	shr    $0xc,%ebx
                      cprintf("allocuvm out of memory\n");
801077f0:	68 dd 86 10 80       	push   $0x801086dd
801077f5:	e8 b6 8e ff ff       	call   801006b0 <cprintf>
	acquire(&shmpagetable->lock);
801077fa:	c7 04 24 80 b4 10 80 	movl   $0x8010b480,(%esp)
80107801:	e8 9a ce ff ff       	call   801046a0 <acquire>
	while(endIndex != shmpgtable.lastShmSegIndex){
80107806:	8b 15 b4 34 13 80    	mov    0x801334b4,%edx
8010780c:	83 c4 10             	add    $0x10,%esp
8010780f:	39 d3                	cmp    %edx,%ebx
80107811:	74 40                	je     80107853 <allocShmSeg+0x183>
80107813:	8d 04 9b             	lea    (%ebx,%ebx,4),%eax
80107816:	8d 14 92             	lea    (%edx,%edx,4),%edx
80107819:	8d 04 c5 b4 b4 10 80 	lea    -0x7fef4b4c(,%eax,8),%eax
80107820:	8d 14 d5 b4 b4 10 80 	lea    -0x7fef4b4c(,%edx,8),%edx
80107827:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010782e:	00 
8010782f:	90                   	nop
		shmpgtable.shm_segs[endIndex].pa = 0;
80107830:	c7 40 24 00 00 00 00 	movl   $0x0,0x24(%eax)
	while(endIndex != shmpgtable.lastShmSegIndex){
80107837:	83 e8 28             	sub    $0x28,%eax
		shmpgtable.shm_segs[endIndex].shm_perm.__key = -1;
8010783a:	c7 40 28 ff ff ff ff 	movl   $0xffffffff,0x28(%eax)
		shmpgtable.shm_segs[endIndex].shm_segsz = 0;
80107841:	c7 40 30 00 00 00 00 	movl   $0x0,0x30(%eax)
		shmpgtable.shm_segs[endIndex].shm_perm.mode = 0;
80107848:	c7 40 2c 00 00 00 00 	movl   $0x0,0x2c(%eax)
	while(endIndex != shmpgtable.lastShmSegIndex){
8010784f:	39 d0                	cmp    %edx,%eax
80107851:	75 dd                	jne    80107830 <allocShmSeg+0x160>
	release(&shmpagetable->lock);
80107853:	83 ec 0c             	sub    $0xc,%esp
80107856:	68 80 b4 10 80       	push   $0x8010b480
8010785b:	e8 e0 cd ff ff       	call   80104640 <release>
}
80107860:	83 c4 10             	add    $0x10,%esp
                      return -1;
80107863:	ba ff ff ff ff       	mov    $0xffffffff,%edx
	// update shm_info
	shm_info.used_ids += 1;
	shm_info.shm_tot = shmpgtable.lastShmSegIndex + 1;

        return shmid;
}
80107868:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010786b:	89 d0                	mov    %edx,%eax
8010786d:	5b                   	pop    %ebx
8010786e:	5e                   	pop    %esi
8010786f:	5f                   	pop    %edi
80107870:	5d                   	pop    %ebp
80107871:	c3                   	ret
80107872:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
	shm_info.shm_tot = shmpgtable.lastShmSegIndex + 1;
80107878:	a1 b4 34 13 80       	mov    0x801334b4,%eax
	shm_info.used_ids += 1;
8010787d:	8b 55 d4             	mov    -0x2c(%ebp),%edx
80107880:	83 05 40 d5 33 80 01 	addl   $0x1,0x8033d540
	shm_info.shm_tot = shmpgtable.lastShmSegIndex + 1;
80107887:	83 c0 01             	add    $0x1,%eax
8010788a:	a3 44 d5 33 80       	mov    %eax,0x8033d544
}
8010788f:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107892:	89 d0                	mov    %edx,%eax
80107894:	5b                   	pop    %ebx
80107895:	5e                   	pop    %esi
80107896:	5f                   	pop    %edi
80107897:	5d                   	pop    %ebp
80107898:	c3                   	ret
80107899:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
			incrementLastIndex = 1;
801078a0:	c7 45 d8 01 00 00 00 	movl   $0x1,-0x28(%ebp)
			index = shmpgtable.lastShmSegIndex + 1;
801078a7:	8d 57 01             	lea    0x1(%edi),%edx
			incrementLastIndex = 1;
801078aa:	e9 b4 fe ff ff       	jmp    80107763 <allocShmSeg+0x93>
801078af:	c7 45 d8 01 00 00 00 	movl   $0x1,-0x28(%ebp)
			index = shmpgtable.lastShmSegIndex + 1;
801078b6:	8d 57 01             	lea    0x1(%edi),%edx
		if(index + reqPages > SHMMAXSEG){
801078b9:	e9 b5 fe ff ff       	jmp    80107773 <allocShmSeg+0xa3>
                return EINVAL;
801078be:	ba 9a ff ff ff       	mov    $0xffffff9a,%edx
801078c3:	eb a3                	jmp    80107868 <allocShmSeg+0x198>
			return ENOSPC;
801078c5:	ba 97 ff ff ff       	mov    $0xffffff97,%edx
801078ca:	eb 9c                	jmp    80107868 <allocShmSeg+0x198>
801078cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801078d0 <allocshmuvm>:


void* allocshmuvm(int shmid, void *shmaddr, int reqPages, int si, int shmflag){
801078d0:	55                   	push   %ebp
801078d1:	89 e5                	mov    %esp,%ebp
801078d3:	57                   	push   %edi
801078d4:	56                   	push   %esi
801078d5:	53                   	push   %ebx
801078d6:	83 ec 28             	sub    $0x28,%esp
	cmostime(&r);
801078d9:	68 28 d5 33 80       	push   $0x8033d528
801078de:	e8 2d b1 ff ff       	call   80102a10 <cmostime>
	struct proc *process = myproc();
801078e3:	e8 e8 c0 ff ff       	call   801039d0 <myproc>
801078e8:	89 45 d8             	mov    %eax,-0x28(%ebp)
801078eb:	89 c6                	mov    %eax,%esi
	void* va = shmaddr;
	acquire(&shmpgtable.lock);
801078ed:	c7 04 24 80 b4 10 80 	movl   $0x8010b480,(%esp)
801078f4:	e8 a7 cd ff ff       	call   801046a0 <acquire>
	for(int i = 0; i < reqPages; i++){
801078f9:	8b 45 10             	mov    0x10(%ebp),%eax
801078fc:	83 c4 10             	add    $0x10,%esp
801078ff:	85 c0                	test   %eax,%eax
80107901:	0f 8e e9 00 00 00    	jle    801079f0 <allocshmuvm+0x120>
		process->shmsegs[si + i].isAttached = 1;
		process->shmsegs[si + i].shmid = shmid;
		// (shmflag & 02) == 1 ==> read and write permission on the shm segment, (shmflag & 02) == 0 ==> only read permission.
		// cprintf("\nva%d",(int)va);
		if(mappages(myproc()->pgdir, (void *)va, PGSIZE, V2P(shmpgtable.shm_segs[shmid + i].pa), ((shmflag & 02) ? (PTE_W|PTE_U) : PTE_U)) < 0){
80107907:	8b 45 18             	mov    0x18(%ebp),%eax
8010790a:	83 e0 02             	and    $0x2,%eax
8010790d:	83 f8 01             	cmp    $0x1,%eax
80107910:	8b 45 08             	mov    0x8(%ebp),%eax
80107913:	19 d2                	sbb    %edx,%edx
	for(int i = 0; i < reqPages; i++){
80107915:	31 ff                	xor    %edi,%edi
80107917:	8d 04 80             	lea    (%eax,%eax,4),%eax
8010791a:	83 e2 fe             	and    $0xfffffffe,%edx
8010791d:	8d 1c c5 c0 b4 10 80 	lea    -0x7fef4b40(,%eax,8),%ebx
80107924:	8b 45 14             	mov    0x14(%ebp),%eax
80107927:	83 c2 06             	add    $0x6,%edx
8010792a:	89 55 dc             	mov    %edx,-0x24(%ebp)
8010792d:	8d 04 c6             	lea    (%esi,%eax,8),%eax
	void* va = shmaddr;
80107930:	8b 75 0c             	mov    0xc(%ebp),%esi
80107933:	89 45 e0             	mov    %eax,-0x20(%ebp)
80107936:	eb 45                	jmp    8010797d <allocshmuvm+0xad>
80107938:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010793f:	00 
			deallocuvm(myproc()->pgdir, (uint)va, (uint)shmaddr);
			return (void*)ENOMEM;
		}
		shmpgtable.shm_segs[shmid + i].shm_nattch += 1;
		shmpgtable.shm_segs[shmid + i].shm_atime = r.hour*10000+r.minute*100+r.second;
80107940:	6b 0d 2c d5 33 80 64 	imul   $0x64,0x8033d52c,%ecx
		shmpgtable.shm_segs[shmid + i].shm_nattch += 1;
80107947:	83 43 14 01          	addl   $0x1,0x14(%ebx)
	for(int i = 0; i < reqPages; i++){
8010794b:	83 c7 01             	add    $0x1,%edi
8010794e:	83 c3 28             	add    $0x28,%ebx
		shmpgtable.shm_segs[shmid + i].shm_atime = r.hour*10000+r.minute*100+r.second;
80107951:	69 05 30 d5 33 80 10 	imul   $0x2710,0x8033d530,%eax
80107958:	27 00 00 
		shmpgtable.shm_segs[shmid + i].shm_ctime = r.hour*10000+r.minute*100+r.second;
		shmpgtable.shm_segs[shmid + i].shm_lpid = process->pid;
		va += PGSIZE;
8010795b:	81 c6 00 10 00 00    	add    $0x1000,%esi
		shmpgtable.shm_segs[shmid + i].shm_atime = r.hour*10000+r.minute*100+r.second;
80107961:	01 c8                	add    %ecx,%eax
80107963:	03 05 28 d5 33 80    	add    0x8033d528,%eax
80107969:	89 43 d8             	mov    %eax,-0x28(%ebx)
		shmpgtable.shm_segs[shmid + i].shm_ctime = r.hour*10000+r.minute*100+r.second;
8010796c:	89 43 e0             	mov    %eax,-0x20(%ebx)
		shmpgtable.shm_segs[shmid + i].shm_lpid = process->pid;
8010796f:	8b 45 d8             	mov    -0x28(%ebp),%eax
80107972:	8b 40 10             	mov    0x10(%eax),%eax
80107975:	89 43 e8             	mov    %eax,-0x18(%ebx)
	for(int i = 0; i < reqPages; i++){
80107978:	39 7d 10             	cmp    %edi,0x10(%ebp)
8010797b:	74 73                	je     801079f0 <allocshmuvm+0x120>
		process->shmsegs[si + i].isAttached = 1;
8010797d:	8b 45 e0             	mov    -0x20(%ebp),%eax
		process->shmsegs[si + i].shmid = shmid;
80107980:	8b 55 08             	mov    0x8(%ebp),%edx
		process->shmsegs[si + i].isAttached = 1;
80107983:	c7 44 f8 7c 01 00 00 	movl   $0x1,0x7c(%eax,%edi,8)
8010798a:	00 
		process->shmsegs[si + i].shmid = shmid;
8010798b:	89 94 f8 80 00 00 00 	mov    %edx,0x80(%eax,%edi,8)
		if(mappages(myproc()->pgdir, (void *)va, PGSIZE, V2P(shmpgtable.shm_segs[shmid + i].pa), ((shmflag & 02) ? (PTE_W|PTE_U) : PTE_U)) < 0){
80107992:	8b 43 18             	mov    0x18(%ebx),%eax
80107995:	8d 88 00 00 00 80    	lea    -0x80000000(%eax),%ecx
8010799b:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
8010799e:	e8 2d c0 ff ff       	call   801039d0 <myproc>
801079a3:	83 ec 0c             	sub    $0xc,%esp
801079a6:	ff 75 dc             	push   -0x24(%ebp)
801079a9:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
801079ac:	51                   	push   %ecx
801079ad:	68 00 10 00 00       	push   $0x1000
801079b2:	56                   	push   %esi
801079b3:	ff 70 04             	push   0x4(%eax)
801079b6:	e8 25 f2 ff ff       	call   80106be0 <mappages>
801079bb:	83 c4 20             	add    $0x20,%esp
801079be:	85 c0                	test   %eax,%eax
801079c0:	0f 89 7a ff ff ff    	jns    80107940 <allocshmuvm+0x70>
			deallocuvm(myproc()->pgdir, (uint)va, (uint)shmaddr);
801079c6:	e8 05 c0 ff ff       	call   801039d0 <myproc>
801079cb:	83 ec 04             	sub    $0x4,%esp
801079ce:	ff 75 0c             	push   0xc(%ebp)
801079d1:	56                   	push   %esi
801079d2:	ff 70 04             	push   0x4(%eax)
801079d5:	e8 76 f6 ff ff       	call   80107050 <deallocuvm>
			return (void*)ENOMEM;
801079da:	83 c4 10             	add    $0x10,%esp
	}
	release(&shmpgtable.lock);
	return shmaddr;
}
801079dd:	8d 65 f4             	lea    -0xc(%ebp),%esp
			return (void*)ENOMEM;
801079e0:	b8 98 ff ff ff       	mov    $0xffffff98,%eax
}
801079e5:	5b                   	pop    %ebx
801079e6:	5e                   	pop    %esi
801079e7:	5f                   	pop    %edi
801079e8:	5d                   	pop    %ebp
801079e9:	c3                   	ret
801079ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
	release(&shmpgtable.lock);
801079f0:	83 ec 0c             	sub    $0xc,%esp
801079f3:	68 80 b4 10 80       	push   $0x8010b480
801079f8:	e8 43 cc ff ff       	call   80104640 <release>
	return shmaddr;
801079fd:	8b 45 0c             	mov    0xc(%ebp),%eax
80107a00:	83 c4 10             	add    $0x10,%esp
}
80107a03:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107a06:	5b                   	pop    %ebx
80107a07:	5e                   	pop    %esi
80107a08:	5f                   	pop    %edi
80107a09:	5d                   	pop    %ebp
80107a0a:	c3                   	ret
80107a0b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80107a10 <shminfoHelper>:

// Prints the info about all the shm segments using shmpgtable
void shminfoHelper(){
80107a10:	55                   	push   %ebp
80107a11:	89 e5                	mov    %esp,%ebp
80107a13:	57                   	push   %edi
80107a14:	56                   	push   %esi
80107a15:	53                   	push   %ebx
80107a16:	83 ec 18             	sub    $0x18,%esp
	cprintf("--------------- Shared Memory Segments ---------------\n");
80107a19:	68 08 8a 10 80       	push   $0x80108a08
80107a1e:	e8 8d 8c ff ff       	call   801006b0 <cprintf>
	cprintf("Last segment index: %d\n", shmpgtable.lastShmSegIndex);
80107a23:	5a                   	pop    %edx
80107a24:	59                   	pop    %ecx
80107a25:	ff 35 b4 34 13 80    	push   0x801334b4
80107a2b:	68 78 87 10 80       	push   $0x80108778
80107a30:	e8 7b 8c ff ff       	call   801006b0 <cprintf>
	cprintf("------------------------------------------------------\n");
80107a35:	c7 04 24 40 8a 10 80 	movl   $0x80108a40,(%esp)
80107a3c:	e8 6f 8c ff ff       	call   801006b0 <cprintf>


	if(shmpgtable.lastShmSegIndex == -1)
80107a41:	83 c4 10             	add    $0x10,%esp
80107a44:	83 3d b4 34 13 80 ff 	cmpl   $0xffffffff,0x801334b4
80107a4b:	74 61                	je     80107aae <shminfoHelper+0x9e>
		return;

	cprintf("Key \t Shmid \t Size \t nattach \t lpid\n\n");
80107a4d:	83 ec 0c             	sub    $0xc,%esp
80107a50:	68 78 8a 10 80       	push   $0x80108a78
80107a55:	e8 56 8c ff ff       	call   801006b0 <cprintf>
	int lastKey = -1;
	for(int i = 0; i <= shmpgtable.lastShmSegIndex; i++){
80107a5a:	a1 b4 34 13 80       	mov    0x801334b4,%eax
80107a5f:	83 c4 10             	add    $0x10,%esp
80107a62:	85 c0                	test   %eax,%eax
80107a64:	78 48                	js     80107aae <shminfoHelper+0x9e>
80107a66:	bb b4 b4 10 80       	mov    $0x8010b4b4,%ebx
80107a6b:	31 ff                	xor    %edi,%edi
	int lastKey = -1;
80107a6d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80107a72:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
		int currentKey = shmpgtable.shm_segs[i].shm_perm.__key;
80107a78:	8b 33                	mov    (%ebx),%esi
		if(currentKey == -1){
			// this is unallocated
			continue;
		}

		if(lastKey == currentKey){
80107a7a:	39 c6                	cmp    %eax,%esi
80107a7c:	74 22                	je     80107aa0 <shminfoHelper+0x90>
80107a7e:	83 fe ff             	cmp    $0xffffffff,%esi
80107a81:	74 1d                	je     80107aa0 <shminfoHelper+0x90>
			// this struct is part of same struct which is already printed
			continue;
		}

		cprintf("%d \t %d \t %d \t %d \t\t %d\n", currentKey, i, shmpgtable.shm_segs[i].shm_segsz, shmpgtable.shm_segs[i].shm_nattch, shmpgtable.shm_segs[i].shm_lpid);
80107a83:	83 ec 08             	sub    $0x8,%esp
80107a86:	ff 73 1c             	push   0x1c(%ebx)
80107a89:	ff 73 20             	push   0x20(%ebx)
80107a8c:	ff 73 08             	push   0x8(%ebx)
80107a8f:	57                   	push   %edi
80107a90:	56                   	push   %esi
80107a91:	68 90 87 10 80       	push   $0x80108790
80107a96:	e8 15 8c ff ff       	call   801006b0 <cprintf>
80107a9b:	83 c4 20             	add    $0x20,%esp

		lastKey = currentKey;
80107a9e:	89 f0                	mov    %esi,%eax
	for(int i = 0; i <= shmpgtable.lastShmSegIndex; i++){
80107aa0:	83 c7 01             	add    $0x1,%edi
80107aa3:	83 c3 28             	add    $0x28,%ebx
80107aa6:	39 3d b4 34 13 80    	cmp    %edi,0x801334b4
80107aac:	7d ca                	jge    80107a78 <shminfoHelper+0x68>
	}

	return;
}
80107aae:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107ab1:	5b                   	pop    %ebx
80107ab2:	5e                   	pop    %esi
80107ab3:	5f                   	pop    %edi
80107ab4:	5d                   	pop    %ebp
80107ab5:	c3                   	ret
80107ab6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80107abd:	00 
80107abe:	66 90                	xchg   %ax,%ax

80107ac0 <shmgetHelper>:

// Helper function for sys_shmget
int shmgetHelper(int key, uint size, int shmflag){
80107ac0:	55                   	push   %ebp
80107ac1:	89 e5                	mov    %esp,%ebp
80107ac3:	57                   	push   %edi
80107ac4:	56                   	push   %esi
80107ac5:	53                   	push   %ebx
80107ac6:	83 ec 1c             	sub    $0x1c,%esp
80107ac9:	8b 45 0c             	mov    0xc(%ebp),%eax
80107acc:	8b 4d 08             	mov    0x8(%ebp),%ecx
80107acf:	8b 7d 10             	mov    0x10(%ebp),%edi
80107ad2:	89 45 e4             	mov    %eax,-0x1c(%ebp)
	int shmid = -1;
	int found = 0;
	int i = 0;
	
	if(key == IPC_PRIVATE){
80107ad5:	81 f9 61 79 fe ff    	cmp    $0xfffe7961,%ecx
80107adb:	0f 84 8f 00 00 00    	je     80107b70 <shmgetHelper+0xb0>
		key = generate_random_key();
	}
	if(shmpgtable.lastShmSegIndex != -1){
80107ae1:	8b 1d b4 34 13 80    	mov    0x801334b4,%ebx
80107ae7:	83 fb ff             	cmp    $0xffffffff,%ebx
80107aea:	74 4c                	je     80107b38 <shmgetHelper+0x78>
		for (i = 0; i <= shmpgtable.lastShmSegIndex; i++){
80107aec:	31 c0                	xor    %eax,%eax
80107aee:	85 db                	test   %ebx,%ebx
80107af0:	79 0d                	jns    80107aff <shmgetHelper+0x3f>
80107af2:	eb 44                	jmp    80107b38 <shmgetHelper+0x78>
80107af4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80107af8:	83 c0 01             	add    $0x1,%eax
80107afb:	39 c3                	cmp    %eax,%ebx
80107afd:	7c 39                	jl     80107b38 <shmgetHelper+0x78>
			if(shmpgtable.shm_segs[i].shm_perm.__key == key){
80107aff:	8d 14 80             	lea    (%eax,%eax,4),%edx
80107b02:	8d 34 d5 00 00 00 00 	lea    0x0(,%edx,8),%esi
80107b09:	39 0c d5 b4 b4 10 80 	cmp    %ecx,-0x7fef4b4c(,%edx,8)
80107b10:	75 e6                	jne    80107af8 <shmgetHelper+0x38>
				break;
			}
		}
	}

	if(shmflag == (IPC_CREAT | IPC_EXCL)){
80107b12:	83 ff 14             	cmp    $0x14,%edi
80107b15:	0f 84 96 00 00 00    	je     80107bb1 <shmgetHelper+0xf1>
		else{
			shmid = allocShmSeg(size, key, shmflag);
			return shmid;
		}
	}
	else if(shmflag == IPC_CREAT){
80107b1b:	83 ff 04             	cmp    $0x4,%edi
80107b1e:	75 27                	jne    80107b47 <shmgetHelper+0x87>
		// in this case, if segment already exists, returns segment identifier. Otherwise a new segement is created.
		if (found && shmpgtable.shm_segs[i].shm_segsz <= size){
80107b20:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80107b23:	3b be bc b4 10 80    	cmp    -0x7fef4b44(%esi),%edi
80107b29:	73 1c                	jae    80107b47 <shmgetHelper+0x87>
		}
		else if (found && !(shmpgtable.shm_segs[i].shm_segsz > size)){
			return EINVAL;
		}
		else{
			shmid = allocShmSeg(size, key, shmflag);
80107b2b:	c7 45 10 04 00 00 00 	movl   $0x4,0x10(%ebp)
80107b32:	eb 23                	jmp    80107b57 <shmgetHelper+0x97>
80107b34:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
	if(shmflag == (IPC_CREAT | IPC_EXCL)){
80107b38:	83 ff 14             	cmp    $0x14,%edi
80107b3b:	74 13                	je     80107b50 <shmgetHelper+0x90>
		// no flag specified, so return segment identifier if segment already exists
		if(found){
			return shmid;
		}
		else{
			return ENOENT;
80107b3d:	b8 99 ff ff ff       	mov    $0xffffff99,%eax
	else if(shmflag == IPC_CREAT){
80107b42:	83 ff 04             	cmp    $0x4,%edi
80107b45:	74 e4                	je     80107b2b <shmgetHelper+0x6b>
		}
	}
}
80107b47:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107b4a:	5b                   	pop    %ebx
80107b4b:	5e                   	pop    %esi
80107b4c:	5f                   	pop    %edi
80107b4d:	5d                   	pop    %ebp
80107b4e:	c3                   	ret
80107b4f:	90                   	nop
			shmid = allocShmSeg(size, key, shmflag);
80107b50:	c7 45 10 14 00 00 00 	movl   $0x14,0x10(%ebp)
			shmid = allocShmSeg(size, key, shmflag);
80107b57:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107b5a:	89 4d 0c             	mov    %ecx,0xc(%ebp)
80107b5d:	89 45 08             	mov    %eax,0x8(%ebp)
}
80107b60:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107b63:	5b                   	pop    %ebx
80107b64:	5e                   	pop    %esi
80107b65:	5f                   	pop    %edi
80107b66:	5d                   	pop    %ebp
			shmid = allocShmSeg(size, key, shmflag);
80107b67:	e9 64 fb ff ff       	jmp    801076d0 <allocShmSeg>
80107b6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
	cmostime(&r);	
80107b70:	83 ec 0c             	sub    $0xc,%esp
80107b73:	68 28 d5 33 80       	push   $0x8033d528
80107b78:	e8 93 ae ff ff       	call   80102a10 <cmostime>
	uint key =  r.second * 10000 + r.minute * 100 + r.hour * 10 + r.day + ticks;
80107b7d:	a1 c0 cc 33 80       	mov    0x8033ccc0,%eax
		key = generate_random_key();
80107b82:	83 c4 10             	add    $0x10,%esp
	uint key =  r.second * 10000 + r.minute * 100 + r.hour * 10 + r.day + ticks;
80107b85:	69 15 28 d5 33 80 10 	imul   $0x2710,0x8033d528,%edx
80107b8c:	27 00 00 
80107b8f:	03 05 34 d5 33 80    	add    0x8033d534,%eax
80107b95:	01 d0                	add    %edx,%eax
80107b97:	6b 15 2c d5 33 80 64 	imul   $0x64,0x8033d52c,%edx
80107b9e:	01 d0                	add    %edx,%eax
80107ba0:	8b 15 30 d5 33 80    	mov    0x8033d530,%edx
80107ba6:	8d 14 92             	lea    (%edx,%edx,4),%edx
80107ba9:	8d 0c 50             	lea    (%eax,%edx,2),%ecx
80107bac:	e9 30 ff ff ff       	jmp    80107ae1 <shmgetHelper+0x21>
			return EEXIST;
80107bb1:	b8 9b ff ff ff       	mov    $0xffffff9b,%eax
80107bb6:	eb 8f                	jmp    80107b47 <shmgetHelper+0x87>
80107bb8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80107bbf:	00 

80107bc0 <shmatHelper>:

// Helper function for sys_shmat
// Attaches the segement with identifier shmid to the process
// i.e. adds the entries of va to pa mappings in the process uvm
void* shmatHelper(int shmid, int shmaddr, int shmflag){
80107bc0:	55                   	push   %ebp
80107bc1:	89 e5                	mov    %esp,%ebp
80107bc3:	57                   	push   %edi
80107bc4:	56                   	push   %esi
80107bc5:	53                   	push   %ebx
80107bc6:	83 ec 0c             	sub    $0xc,%esp
80107bc9:	8b 5d 08             	mov    0x8(%ebp),%ebx
	// check if the shmid is valid
	if(shmid < 0 || shmid > shmpgtable.lastShmSegIndex){
80107bcc:	85 db                	test   %ebx,%ebx
80107bce:	0f 88 cc 00 00 00    	js     80107ca0 <shmatHelper+0xe0>
80107bd4:	39 1d b4 34 13 80    	cmp    %ebx,0x801334b4
80107bda:	0f 8c c0 00 00 00    	jl     80107ca0 <shmatHelper+0xe0>
		return (void*)EINVAL;
	}
	int segsz = shmpgtable.shm_segs[shmid].shm_segsz;
80107be0:	8d 04 9b             	lea    (%ebx,%ebx,4),%eax
80107be3:	8b 14 c5 bc b4 10 80 	mov    -0x7fef4b44(,%eax,8),%edx

	// check if the segment is created
	if(segsz == 0){
		return (void*)EIDRM;
80107bea:	b8 36 ff ff ff       	mov    $0xffffff36,%eax
	if(segsz == 0){
80107bef:	85 d2                	test   %edx,%edx
80107bf1:	0f 84 ae 00 00 00    	je     80107ca5 <shmatHelper+0xe5>
	}

	int reqPages = segsz / PGSIZE;
80107bf7:	8d b2 ff 0f 00 00    	lea    0xfff(%edx),%esi
80107bfd:	0f 49 f2             	cmovns %edx,%esi

	void *va = 0;
	int si = -1;

	struct proc *process = myproc();
80107c00:	e8 cb bd ff ff       	call   801039d0 <myproc>
80107c05:	89 c7                	mov    %eax,%edi

	if( shmaddr == 0){
80107c07:	8b 45 0c             	mov    0xc(%ebp),%eax
	int reqPages = segsz / PGSIZE;
80107c0a:	c1 fe 0c             	sar    $0xc,%esi
	if( shmaddr == 0){
80107c0d:	85 c0                	test   %eax,%eax
80107c0f:	75 3f                	jne    80107c50 <shmatHelper+0x90>
		// address not provided, find suitable address and map the segement
		int index = -1;
		int zc = 0;

		for(int i = 0; i < SHMMAXSEG; i++){
80107c11:	31 c0                	xor    %eax,%eax
		int zc = 0;
80107c13:	31 c9                	xor    %ecx,%ecx
	int si = -1;
80107c15:	ba ff ff ff ff       	mov    $0xffffffff,%edx
80107c1a:	eb 23                	jmp    80107c3f <shmatHelper+0x7f>
80107c1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
			if(process->shmsegs[i].isAttached == 0){
				if(si == -1){
					si = i;
80107c20:	83 fa ff             	cmp    $0xffffffff,%edx
80107c23:	0f 44 d0             	cmove  %eax,%edx
				}
				zc++;
80107c26:	83 c1 01             	add    $0x1,%ecx
				if(zc == reqPages){
80107c29:	39 ce                	cmp    %ecx,%esi
80107c2b:	0f 84 7f 00 00 00    	je     80107cb0 <shmatHelper+0xf0>
		for(int i = 0; i < SHMMAXSEG; i++){
80107c31:	83 c0 01             	add    $0x1,%eax
80107c34:	3d 00 10 00 00       	cmp    $0x1000,%eax
80107c39:	0f 84 90 00 00 00    	je     80107ccf <shmatHelper+0x10f>
			if(process->shmsegs[i].isAttached == 0){
80107c3f:	83 7c c7 7c 00       	cmpl   $0x0,0x7c(%edi,%eax,8)
80107c44:	74 da                	je     80107c20 <shmatHelper+0x60>
					break;
				}
			}
			else{
				si = -1;
				zc = 0;
80107c46:	31 c9                	xor    %ecx,%ecx
				si = -1;
80107c48:	ba ff ff ff ff       	mov    $0xffffffff,%edx
80107c4d:	eb e2                	jmp    80107c31 <shmatHelper+0x71>
80107c4f:	90                   	nop

		va = (void*) ((index * PGSIZE) + HEAPLIMIT);
	}
	else{
		// address provided, check if it is valid and empty
		if( shmaddr > KERNBASE ||  shmaddr < HEAPLIMIT){
80107c50:	81 7d 0c 00 00 00 80 	cmpl   $0x80000000,0xc(%ebp)
80107c57:	77 47                	ja     80107ca0 <shmatHelper+0xe0>
80107c59:	81 7d 0c ff ff ff 7e 	cmpl   $0x7effffff,0xc(%ebp)
80107c60:	7e 3e                	jle    80107ca0 <shmatHelper+0xe0>
			// cprintf("\n%d",shmaddr > KERNBASE );
			// cprintf("\n%d",shmaddr < HEAPLIMIT );
			// cprintf("\n%d  %d  %d \n", shmaddr, (int)HEAPLIMIT, (int)KERNBASE);
			return (void*)EINVAL;
		}
		if (shmflag != SHM_RND && shmaddr % PGSIZE != 0){
80107c62:	83 7d 10 04          	cmpl   $0x4,0x10(%ebp)
80107c66:	74 6e                	je     80107cd6 <shmatHelper+0x116>
80107c68:	f7 45 0c ff 0f 00 00 	testl  $0xfff,0xc(%ebp)
80107c6f:	75 2f                	jne    80107ca0 <shmatHelper+0xe0>
80107c71:	ba 00 10 f8 ff       	mov    $0xfff81000,%edx
	void *va = 0;
80107c76:	31 c9                	xor    %ecx,%ecx
		if (shmflag == SHM_RND){
			va = (void*)PGROUNDDOWN(shmaddr);
		}
		int given_si = ((int)va - HEAPLIMIT) / PGSIZE;

		for(int i = given_si; i < reqPages; i++){
80107c78:	39 f2                	cmp    %esi,%edx
80107c7a:	7d 3d                	jge    80107cb9 <shmatHelper+0xf9>
80107c7c:	8d 44 d7 7c          	lea    0x7c(%edi,%edx,8),%eax
80107c80:	8d 7c f7 7c          	lea    0x7c(%edi,%esi,8),%edi
80107c84:	eb 11                	jmp    80107c97 <shmatHelper+0xd7>
80107c86:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80107c8d:	00 
80107c8e:	66 90                	xchg   %ax,%ax
80107c90:	83 c0 08             	add    $0x8,%eax
80107c93:	39 f8                	cmp    %edi,%eax
80107c95:	74 22                	je     80107cb9 <shmatHelper+0xf9>
			if(process->shmsegs[i].isAttached == 1){
80107c97:	83 38 01             	cmpl   $0x1,(%eax)
80107c9a:	75 f4                	jne    80107c90 <shmatHelper+0xd0>
80107c9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
		return (void*)EINVAL;
80107ca0:	b8 9a ff ff ff       	mov    $0xffffff9a,%eax

	//if (shmflag == SHM_EXEC){
		// Allow the contents of the segment to be  executed. The  caller must have execute permission on the segment.
	//}
	return va;
}
80107ca5:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107ca8:	5b                   	pop    %ebx
80107ca9:	5e                   	pop    %esi
80107caa:	5f                   	pop    %edi
80107cab:	5d                   	pop    %ebp
80107cac:	c3                   	ret
80107cad:	8d 76 00             	lea    0x0(%esi),%esi
		va = (void*) ((index * PGSIZE) + HEAPLIMIT);
80107cb0:	8d 8a 00 f0 07 00    	lea    0x7f000(%edx),%ecx
80107cb6:	c1 e1 0c             	shl    $0xc,%ecx
	if((va = allocshmuvm(shmid, va, reqPages, si, shmflag)) == 0){
80107cb9:	83 ec 0c             	sub    $0xc,%esp
80107cbc:	ff 75 10             	push   0x10(%ebp)
80107cbf:	52                   	push   %edx
80107cc0:	56                   	push   %esi
80107cc1:	51                   	push   %ecx
80107cc2:	53                   	push   %ebx
80107cc3:	e8 08 fc ff ff       	call   801078d0 <allocshmuvm>
80107cc8:	83 c4 20             	add    $0x20,%esp
80107ccb:	85 c0                	test   %eax,%eax
80107ccd:	75 d6                	jne    80107ca5 <shmatHelper+0xe5>
			return (void*)ENOMEM;
80107ccf:	b8 98 ff ff ff       	mov    $0xffffff98,%eax
80107cd4:	eb cf                	jmp    80107ca5 <shmatHelper+0xe5>
			va = (void*)PGROUNDDOWN(shmaddr);
80107cd6:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80107cd9:	81 e1 00 f0 ff ff    	and    $0xfffff000,%ecx
		int given_si = ((int)va - HEAPLIMIT) / PGSIZE;
80107cdf:	8d 91 00 00 00 81    	lea    -0x7f000000(%ecx),%edx
80107ce5:	c1 fa 0c             	sar    $0xc,%edx
80107ce8:	eb 8e                	jmp    80107c78 <shmatHelper+0xb8>
80107cea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80107cf0 <shmdtHelper>:

// Helper function for sys_shmdt
int shmdtHelper(int shmaddr){
80107cf0:	55                   	push   %ebp
80107cf1:	89 e5                	mov    %esp,%ebp
80107cf3:	57                   	push   %edi
80107cf4:	56                   	push   %esi
80107cf5:	53                   	push   %ebx
80107cf6:	83 ec 2c             	sub    $0x2c,%esp
80107cf9:	8b 75 08             	mov    0x8(%ebp),%esi
	if(shmaddr < HEAPLIMIT || shmaddr > KERNBASE){
80107cfc:	81 fe ff ff ff 7e    	cmp    $0x7effffff,%esi
80107d02:	0f 8e 39 01 00 00    	jle    80107e41 <shmdtHelper+0x151>
80107d08:	81 fe 00 00 00 80    	cmp    $0x80000000,%esi
80107d0e:	0f 87 2d 01 00 00    	ja     80107e41 <shmdtHelper+0x151>
		return EINVAL;
	}
	
	cmostime(&r);
80107d14:	83 ec 0c             	sub    $0xc,%esp
	struct proc *process = myproc();
	int si = ((uint)shmaddr - HEAPLIMIT) / PGSIZE;
80107d17:	81 ee 00 00 00 7f    	sub    $0x7f000000,%esi
	cmostime(&r);
80107d1d:	68 28 d5 33 80       	push   $0x8033d528
	int si = ((uint)shmaddr - HEAPLIMIT) / PGSIZE;
80107d22:	c1 ee 0c             	shr    $0xc,%esi
	cmostime(&r);
80107d25:	e8 e6 ac ff ff       	call   80102a10 <cmostime>
	struct proc *process = myproc();
80107d2a:	e8 a1 bc ff ff       	call   801039d0 <myproc>
	if(process->shmsegs[si].isAttached == 0){
80107d2f:	83 c4 10             	add    $0x10,%esp
	struct proc *process = myproc();
80107d32:	89 c2                	mov    %eax,%edx
	if(process->shmsegs[si].isAttached == 0){
80107d34:	8d 04 f0             	lea    (%eax,%esi,8),%eax
80107d37:	89 55 d4             	mov    %edx,-0x2c(%ebp)
80107d3a:	8b 50 7c             	mov    0x7c(%eax),%edx
80107d3d:	89 45 e0             	mov    %eax,-0x20(%ebp)
80107d40:	85 d2                	test   %edx,%edx
80107d42:	0f 84 f9 00 00 00    	je     80107e41 <shmdtHelper+0x151>
		return EINVAL;
	}
	int shmid = process->shmsegs[si].shmid;
80107d48:	8b 88 80 00 00 00    	mov    0x80(%eax),%ecx
	process->shmsegs[si].isAttached = 0;
80107d4e:	c7 40 7c 00 00 00 00 	movl   $0x0,0x7c(%eax)
	process->shmsegs[si].shmid= -1;
80107d55:	c7 80 80 00 00 00 ff 	movl   $0xffffffff,0x80(%eax)
80107d5c:	ff ff ff 
	int size = shmpgtable.shm_segs[shmid].shm_segsz;
80107d5f:	8d 04 8d 00 00 00 00 	lea    0x0(,%ecx,4),%eax
80107d66:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80107d69:	8d 1c 08             	lea    (%eax,%ecx,1),%ebx
80107d6c:	89 45 d8             	mov    %eax,-0x28(%ebp)
80107d6f:	c1 e3 03             	shl    $0x3,%ebx
80107d72:	8b bb bc b4 10 80    	mov    -0x7fef4b44(%ebx),%edi
	int reqPages = size / PGSIZE;
80107d78:	85 ff                	test   %edi,%edi
80107d7a:	8d 87 ff 0f 00 00    	lea    0xfff(%edi),%eax
80107d80:	0f 49 c7             	cmovns %edi,%eax
	acquire(&shmpgtable.lock);
80107d83:	83 ec 0c             	sub    $0xc,%esp
	int reqPages = size / PGSIZE;
80107d86:	c1 f8 0c             	sar    $0xc,%eax
80107d89:	89 45 dc             	mov    %eax,-0x24(%ebp)
	acquire(&shmpgtable.lock);
80107d8c:	68 80 b4 10 80       	push   $0x8010b480
80107d91:	e8 0a c9 ff ff       	call   801046a0 <acquire>
	for(int i = 0; i < reqPages; i++){
80107d96:	83 c4 10             	add    $0x10,%esp
80107d99:	81 ff ff 0f 00 00    	cmp    $0xfff,%edi
80107d9f:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80107da2:	7e 76                	jle    80107e1a <shmdtHelper+0x12a>
80107da4:	8b 55 d4             	mov    -0x2c(%ebp),%edx
80107da7:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
80107daa:	81 c6 00 f0 07 00    	add    $0x7f000,%esi
80107db0:	31 ff                	xor    %edi,%edi
80107db2:	81 c3 c4 b4 10 80    	add    $0x8010b4c4,%ebx
80107db8:	c1 e6 0c             	shl    $0xc,%esi
80107dbb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
		process->shmsegs[si + i].isAttached = 0;
80107dc0:	8b 45 e0             	mov    -0x20(%ebp),%eax
		shmpgtable.shm_segs[shmid + i].shm_nattch -= 1;
		shmpgtable.shm_segs[shmid + i].shm_dtime = r.hour*10000+r.minute*100+r.second;
		shmpgtable.shm_segs[shmid + i].shm_lpid = process->pid;
		// cprintf("\ndt va: %d",((si+i)*PGSIZE)+HEAPLIMIT);
		clearmapping(process->pgdir,(char*)(((si+i)*PGSIZE)+HEAPLIMIT));
80107dc3:	83 ec 08             	sub    $0x8,%esp
		process->shmsegs[si + i].isAttached = 0;
80107dc6:	c7 44 f8 7c 00 00 00 	movl   $0x0,0x7c(%eax,%edi,8)
80107dcd:	00 
		shmpgtable.shm_segs[shmid + i].shm_dtime = r.hour*10000+r.minute*100+r.second;
80107dce:	6b 0d 2c d5 33 80 64 	imul   $0x64,0x8033d52c,%ecx
	for(int i = 0; i < reqPages; i++){
80107dd5:	83 c7 01             	add    $0x1,%edi
		shmpgtable.shm_segs[shmid + i].shm_dtime = r.hour*10000+r.minute*100+r.second;
80107dd8:	69 05 30 d5 33 80 10 	imul   $0x2710,0x8033d530,%eax
80107ddf:	27 00 00 
		shmpgtable.shm_segs[shmid + i].shm_nattch -= 1;
80107de2:	83 6b 10 01          	subl   $0x1,0x10(%ebx)
	for(int i = 0; i < reqPages; i++){
80107de6:	83 c3 28             	add    $0x28,%ebx
		shmpgtable.shm_segs[shmid + i].shm_dtime = r.hour*10000+r.minute*100+r.second;
80107de9:	01 c8                	add    %ecx,%eax
80107deb:	03 05 28 d5 33 80    	add    0x8033d528,%eax
80107df1:	89 43 d8             	mov    %eax,-0x28(%ebx)
		shmpgtable.shm_segs[shmid + i].shm_lpid = process->pid;
80107df4:	8b 42 10             	mov    0x10(%edx),%eax
80107df7:	89 43 e4             	mov    %eax,-0x1c(%ebx)
		clearmapping(process->pgdir,(char*)(((si+i)*PGSIZE)+HEAPLIMIT));
80107dfa:	56                   	push   %esi
	for(int i = 0; i < reqPages; i++){
80107dfb:	81 c6 00 10 00 00    	add    $0x1000,%esi
		clearmapping(process->pgdir,(char*)(((si+i)*PGSIZE)+HEAPLIMIT));
80107e01:	ff 72 04             	push   0x4(%edx)
80107e04:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80107e07:	e8 e4 f3 ff ff       	call   801071f0 <clearmapping>
	for(int i = 0; i < reqPages; i++){
80107e0c:	83 c4 10             	add    $0x10,%esp
80107e0f:	39 7d dc             	cmp    %edi,-0x24(%ebp)
80107e12:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80107e15:	7f a9                	jg     80107dc0 <shmdtHelper+0xd0>
80107e17:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
	}
	shmpgtable.shm_segs[shmid].shm_perm.mode |= SHM_DEST;
80107e1a:	8b 45 d8             	mov    -0x28(%ebp),%eax
	release(&shmpgtable.lock);
80107e1d:	83 ec 0c             	sub    $0xc,%esp
	shmpgtable.shm_segs[shmid].shm_perm.mode |= SHM_DEST;
80107e20:	01 c8                	add    %ecx,%eax
80107e22:	83 0c c5 b8 b4 10 80 	orl    $0x20,-0x7fef4b48(,%eax,8)
80107e29:	20 
	release(&shmpgtable.lock);
80107e2a:	68 80 b4 10 80       	push   $0x8010b480
80107e2f:	e8 0c c8 ff ff       	call   80104640 <release>
	return 0;
80107e34:	83 c4 10             	add    $0x10,%esp
80107e37:	31 c0                	xor    %eax,%eax
}
80107e39:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107e3c:	5b                   	pop    %ebx
80107e3d:	5e                   	pop    %esi
80107e3e:	5f                   	pop    %edi
80107e3f:	5d                   	pop    %ebp
80107e40:	c3                   	ret
		return EINVAL;
80107e41:	b8 9a ff ff ff       	mov    $0xffffff9a,%eax
80107e46:	eb f1                	jmp    80107e39 <shmdtHelper+0x149>
80107e48:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80107e4f:	00 

80107e50 <shmctlHelper>:

// Helper function for sys_shmctl
int shmctlHelper(int shmid, int cmd, struct shmid_ds *buf){
80107e50:	55                   	push   %ebp
80107e51:	89 e5                	mov    %esp,%ebp
80107e53:	57                   	push   %edi
80107e54:	56                   	push   %esi
80107e55:	53                   	push   %ebx
80107e56:	83 ec 1c             	sub    $0x1c,%esp
80107e59:	8b 75 08             	mov    0x8(%ebp),%esi
80107e5c:	8b 55 0c             	mov    0xc(%ebp),%edx
80107e5f:	8b 5d 10             	mov    0x10(%ebp),%ebx
	// for now permission on the segment is not checked

	int reqPages = 1;

	if(shmid < 0 || shmid > shmpgtable.lastShmSegIndex){
80107e62:	85 f6                	test   %esi,%esi
80107e64:	0f 88 16 02 00 00    	js     80108080 <shmctlHelper+0x230>
80107e6a:	39 35 b4 34 13 80    	cmp    %esi,0x801334b4
80107e70:	0f 8c 0a 02 00 00    	jl     80108080 <shmctlHelper+0x230>
		return EINVAL;
	}

	if(shmpgtable.shm_segs[shmid].shm_perm.__key == -1){
80107e76:	8d 04 b5 00 00 00 00 	lea    0x0(,%esi,4),%eax
80107e7d:	8d 0c 30             	lea    (%eax,%esi,1),%ecx
80107e80:	83 3c cd b4 b4 10 80 	cmpl   $0xffffffff,-0x7fef4b4c(,%ecx,8)
80107e87:	ff 
80107e88:	0f 84 06 02 00 00    	je     80108094 <shmctlHelper+0x244>
		return EIDRM;
	}

	if(cmd == IPC_STAT){
80107e8e:	83 fa 05             	cmp    $0x5,%edx
80107e91:	0f 87 7f 00 00 00    	ja     80107f16 <shmctlHelper+0xc6>
80107e97:	ff 24 95 d0 8d 10 80 	jmp    *-0x7fef7230(,%edx,4)
80107e9e:	66 90                	xchg   %ax,%ax
	}
	else if(cmd == SHM_INFO){
		// copy info in shm_info to the buf
		// this buf will point to struct of type shm_info, so cast is required
		// we're instead printing it
		cprintf("shm_info.used_ids: %d\n", shm_info.used_ids);
80107ea0:	83 ec 08             	sub    $0x8,%esp
80107ea3:	ff 35 40 d5 33 80    	push   0x8033d540
80107ea9:	68 12 88 10 80       	push   $0x80108812
80107eae:	e8 fd 87 ff ff       	call   801006b0 <cprintf>
		cprintf("shm_info.shm_tot: %d\n", shm_info.shm_tot);
80107eb3:	58                   	pop    %eax
80107eb4:	5a                   	pop    %edx
80107eb5:	ff 35 44 d5 33 80    	push   0x8033d544
80107ebb:	68 29 88 10 80       	push   $0x80108829
80107ec0:	e8 eb 87 ff ff       	call   801006b0 <cprintf>

		return shmpgtable.lastShmSegIndex;
80107ec5:	a1 b4 34 13 80       	mov    0x801334b4,%eax
80107eca:	83 c4 10             	add    $0x10,%esp
	}

	return 0;
}
80107ecd:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107ed0:	5b                   	pop    %ebx
80107ed1:	5e                   	pop    %esi
80107ed2:	5f                   	pop    %edi
80107ed3:	5d                   	pop    %ebp
80107ed4:	c3                   	ret
80107ed5:	8d 76 00             	lea    0x0(%esi),%esi
		buf->shm_perm = shmpgtable.shm_segs[shmid].shm_perm;
80107ed8:	01 f0                	add    %esi,%eax
80107eda:	8d 0c c5 80 b4 10 80 	lea    -0x7fef4b80(,%eax,8),%ecx
80107ee1:	8b 41 34             	mov    0x34(%ecx),%eax
80107ee4:	8b 51 38             	mov    0x38(%ecx),%edx
80107ee7:	89 03                	mov    %eax,(%ebx)
80107ee9:	89 53 04             	mov    %edx,0x4(%ebx)
		buf->shm_segsz = shmpgtable.shm_segs[shmid].shm_segsz;
80107eec:	8b 41 3c             	mov    0x3c(%ecx),%eax
80107eef:	89 43 08             	mov    %eax,0x8(%ebx)
		buf->shm_atime = shmpgtable.shm_segs[shmid].shm_atime;
80107ef2:	8b 41 40             	mov    0x40(%ecx),%eax
80107ef5:	89 43 0c             	mov    %eax,0xc(%ebx)
		buf->shm_dtime = shmpgtable.shm_segs[shmid].shm_dtime;
80107ef8:	8b 41 44             	mov    0x44(%ecx),%eax
80107efb:	89 43 10             	mov    %eax,0x10(%ebx)
		buf->shm_ctime = shmpgtable.shm_segs[shmid].shm_ctime;
80107efe:	8b 41 48             	mov    0x48(%ecx),%eax
80107f01:	89 43 14             	mov    %eax,0x14(%ebx)
		buf->shm_cpid = shmpgtable.shm_segs[shmid].shm_cpid;
80107f04:	8b 41 4c             	mov    0x4c(%ecx),%eax
80107f07:	89 43 18             	mov    %eax,0x18(%ebx)
		buf->shm_lpid = shmpgtable.shm_segs[shmid].shm_lpid;
80107f0a:	8b 41 50             	mov    0x50(%ecx),%eax
80107f0d:	89 43 1c             	mov    %eax,0x1c(%ebx)
		buf->shm_nattch = shmpgtable.shm_segs[shmid].shm_nattch;
80107f10:	8b 41 54             	mov    0x54(%ecx),%eax
80107f13:	89 43 20             	mov    %eax,0x20(%ebx)
		return 0;
80107f16:	31 c0                	xor    %eax,%eax
}
80107f18:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107f1b:	5b                   	pop    %ebx
80107f1c:	5e                   	pop    %esi
80107f1d:	5f                   	pop    %edi
80107f1e:	5d                   	pop    %ebp
80107f1f:	c3                   	ret
		if (shmpgtable.shm_segs[shmid].shm_perm.mode & SHM_R){
80107f20:	01 f0                	add    %esi,%eax
80107f22:	8d 0c c5 80 b4 10 80 	lea    -0x7fef4b80(,%eax,8),%ecx
80107f29:	f6 41 38 01          	testb  $0x1,0x38(%ecx)
80107f2d:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80107f30:	0f 85 54 01 00 00    	jne    8010808a <shmctlHelper+0x23a>
		acquire(&shmpgtable.lock);
80107f36:	83 ec 0c             	sub    $0xc,%esp
		reqPages = buf->shm_segsz / PGSIZE;
80107f39:	8b 7b 08             	mov    0x8(%ebx),%edi
		acquire(&shmpgtable.lock);
80107f3c:	68 80 b4 10 80       	push   $0x8010b480
		reqPages = buf->shm_segsz / PGSIZE;
80107f41:	c1 ef 0c             	shr    $0xc,%edi
		acquire(&shmpgtable.lock);
80107f44:	e8 57 c7 ff ff       	call   801046a0 <acquire>
		for (int i = 0; i < reqPages; i++){
80107f49:	83 c4 10             	add    $0x10,%esp
80107f4c:	85 ff                	test   %edi,%edi
80107f4e:	74 4c                	je     80107f9c <shmctlHelper+0x14c>
80107f50:	01 f7                	add    %esi,%edi
80107f52:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80107f55:	8d 04 bf             	lea    (%edi,%edi,4),%eax
80107f58:	8d 34 c5 80 b4 10 80 	lea    -0x7fef4b80(,%eax,8),%esi
80107f5f:	90                   	nop
			shmpgtable.shm_segs[shmid + i].shm_perm = buf->shm_perm;
80107f60:	8b 03                	mov    (%ebx),%eax
80107f62:	8b 53 04             	mov    0x4(%ebx),%edx
		for (int i = 0; i < reqPages; i++){
80107f65:	83 c1 28             	add    $0x28,%ecx
			shmpgtable.shm_segs[shmid + i].shm_perm = buf->shm_perm;
80107f68:	89 41 0c             	mov    %eax,0xc(%ecx)
80107f6b:	89 51 10             	mov    %edx,0x10(%ecx)
			shmpgtable.shm_segs[shmid + i].shm_segsz = buf->shm_segsz;
80107f6e:	8b 43 08             	mov    0x8(%ebx),%eax
80107f71:	89 41 14             	mov    %eax,0x14(%ecx)
			shmpgtable.shm_segs[shmid + i].shm_atime = buf->shm_atime;
80107f74:	8b 43 0c             	mov    0xc(%ebx),%eax
80107f77:	89 41 18             	mov    %eax,0x18(%ecx)
			shmpgtable.shm_segs[shmid + i].shm_dtime = buf->shm_dtime;
80107f7a:	8b 43 10             	mov    0x10(%ebx),%eax
80107f7d:	89 41 1c             	mov    %eax,0x1c(%ecx)
			shmpgtable.shm_segs[shmid + i].shm_ctime = buf->shm_ctime;
80107f80:	8b 43 14             	mov    0x14(%ebx),%eax
80107f83:	89 41 20             	mov    %eax,0x20(%ecx)
			shmpgtable.shm_segs[shmid + i].shm_cpid = buf->shm_cpid;
80107f86:	8b 43 18             	mov    0x18(%ebx),%eax
80107f89:	89 41 24             	mov    %eax,0x24(%ecx)
			shmpgtable.shm_segs[shmid + i].shm_lpid = buf->shm_lpid;
80107f8c:	8b 43 1c             	mov    0x1c(%ebx),%eax
80107f8f:	89 41 28             	mov    %eax,0x28(%ecx)
			shmpgtable.shm_segs[shmid + i].shm_nattch = buf->shm_nattch;
80107f92:	8b 43 20             	mov    0x20(%ebx),%eax
80107f95:	89 41 2c             	mov    %eax,0x2c(%ecx)
		for (int i = 0; i < reqPages; i++){
80107f98:	39 f1                	cmp    %esi,%ecx
80107f9a:	75 c4                	jne    80107f60 <shmctlHelper+0x110>
		release(&shmpgtable.lock);
80107f9c:	83 ec 0c             	sub    $0xc,%esp
80107f9f:	68 80 b4 10 80       	push   $0x8010b480
80107fa4:	e8 97 c6 ff ff       	call   80104640 <release>
		return 0;
80107fa9:	83 c4 10             	add    $0x10,%esp
		return 0;
80107fac:	31 c0                	xor    %eax,%eax
80107fae:	e9 65 ff ff ff       	jmp    80107f18 <shmctlHelper+0xc8>
80107fb3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
		reqPages = shmpgtable.shm_segs[shmid].shm_segsz / PGSIZE;
80107fb8:	01 f0                	add    %esi,%eax
80107fba:	8d 04 c5 80 b4 10 80 	lea    -0x7fef4b80(,%eax,8),%eax
		for (int i = 0; i < reqPages; i++){
80107fc1:	8b 50 3c             	mov    0x3c(%eax),%edx
80107fc4:	c1 ea 0c             	shr    $0xc,%edx
80107fc7:	0f 84 49 ff ff ff    	je     80107f16 <shmctlHelper+0xc6>
80107fcd:	01 f2                	add    %esi,%edx
80107fcf:	8d 14 92             	lea    (%edx,%edx,4),%edx
80107fd2:	8d 14 d5 80 b4 10 80 	lea    -0x7fef4b80(,%edx,8),%edx
80107fd9:	89 d1                	mov    %edx,%ecx
80107fdb:	29 c1                	sub    %eax,%ecx
80107fdd:	83 e1 08             	and    $0x8,%ecx
80107fe0:	74 16                	je     80107ff8 <shmctlHelper+0x1a8>
			shmpgtable.shm_segs[shmid + i].shm_perm.mode |= SHM_DEST;
80107fe2:	83 48 38 20          	orl    $0x20,0x38(%eax)
		for (int i = 0; i < reqPages; i++){
80107fe6:	83 c0 28             	add    $0x28,%eax
80107fe9:	39 d0                	cmp    %edx,%eax
80107feb:	0f 84 25 ff ff ff    	je     80107f16 <shmctlHelper+0xc6>
80107ff1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
			shmpgtable.shm_segs[shmid + i].shm_perm.mode |= SHM_DEST;
80107ff8:	83 48 38 20          	orl    $0x20,0x38(%eax)
80107ffc:	83 48 60 20          	orl    $0x20,0x60(%eax)
		for (int i = 0; i < reqPages; i++){
80108000:	83 c0 50             	add    $0x50,%eax
80108003:	39 d0                	cmp    %edx,%eax
80108005:	75 f1                	jne    80107ff8 <shmctlHelper+0x1a8>
		return 0;
80108007:	31 c0                	xor    %eax,%eax
80108009:	e9 0a ff ff ff       	jmp    80107f18 <shmctlHelper+0xc8>
8010800e:	66 90                	xchg   %ax,%ax
		cprintf("ipc_info.shmmax: %d\n", ipc_info.shmmax);
80108010:	83 ec 08             	sub    $0x8,%esp
80108013:	ff 35 60 b4 10 80    	push   0x8010b460
80108019:	68 a9 87 10 80       	push   $0x801087a9
8010801e:	e8 8d 86 ff ff       	call   801006b0 <cprintf>
		cprintf("ipc_info.shmmin: %d\n", ipc_info.shmmin);
80108023:	59                   	pop    %ecx
80108024:	5b                   	pop    %ebx
80108025:	ff 35 64 b4 10 80    	push   0x8010b464
8010802b:	68 be 87 10 80       	push   $0x801087be
80108030:	e8 7b 86 ff ff       	call   801006b0 <cprintf>
		cprintf("ipc_info.shmmni: %d\n", ipc_info.shmmni);
80108035:	5e                   	pop    %esi
80108036:	5f                   	pop    %edi
80108037:	ff 35 68 b4 10 80    	push   0x8010b468
8010803d:	68 d3 87 10 80       	push   $0x801087d3
80108042:	e8 69 86 ff ff       	call   801006b0 <cprintf>
		cprintf("ipc_info.shmseg: %d\n", ipc_info.shmseg);
80108047:	58                   	pop    %eax
80108048:	5a                   	pop    %edx
80108049:	ff 35 6c b4 10 80    	push   0x8010b46c
8010804f:	68 e8 87 10 80       	push   $0x801087e8
80108054:	e8 57 86 ff ff       	call   801006b0 <cprintf>
		cprintf("ipc_info.shmall: %d\n", ipc_info.shmall);
80108059:	59                   	pop    %ecx
8010805a:	5b                   	pop    %ebx
8010805b:	ff 35 70 b4 10 80    	push   0x8010b470
80108061:	68 fd 87 10 80       	push   $0x801087fd
80108066:	e8 45 86 ff ff       	call   801006b0 <cprintf>
		return shmpgtable.lastShmSegIndex;
8010806b:	a1 b4 34 13 80       	mov    0x801334b4,%eax
80108070:	83 c4 10             	add    $0x10,%esp
}
80108073:	8d 65 f4             	lea    -0xc(%ebp),%esp
80108076:	5b                   	pop    %ebx
80108077:	5e                   	pop    %esi
80108078:	5f                   	pop    %edi
80108079:	5d                   	pop    %ebp
8010807a:	c3                   	ret
8010807b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
		return EINVAL;
80108080:	b8 9a ff ff ff       	mov    $0xffffff9a,%eax
80108085:	e9 43 fe ff ff       	jmp    80107ecd <shmctlHelper+0x7d>
			return -1;
8010808a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010808f:	e9 39 fe ff ff       	jmp    80107ecd <shmctlHelper+0x7d>
		return EIDRM;
80108094:	b8 36 ff ff ff       	mov    $0xffffff36,%eax
80108099:	e9 2f fe ff ff       	jmp    80107ecd <shmctlHelper+0x7d>
8010809e:	66 90                	xchg   %ax,%ax

801080a0 <freeshmPages>:

void freeshmPages(int shmid){
801080a0:	55                   	push   %ebp
801080a1:	89 e5                	mov    %esp,%ebp
801080a3:	57                   	push   %edi
801080a4:	56                   	push   %esi
801080a5:	53                   	push   %ebx
801080a6:	83 ec 0c             	sub    $0xc,%esp
801080a9:	8b 45 08             	mov    0x8(%ebp),%eax
	int reqPages = shmpgtable.shm_segs[shmid].shm_segsz / PGSIZE;
801080ac:	8d 1c 80             	lea    (%eax,%eax,4),%ebx
801080af:	c1 e3 03             	shl    $0x3,%ebx

	for(int i = 0; i < reqPages; i++){
801080b2:	8b b3 bc b4 10 80    	mov    -0x7fef4b44(%ebx),%esi
801080b8:	c1 ee 0c             	shr    $0xc,%esi
801080bb:	74 6e                	je     8010812b <freeshmPages+0x8b>
801080bd:	81 c3 b4 b4 10 80    	add    $0x8010b4b4,%ebx
801080c3:	31 ff                	xor    %edi,%edi
801080c5:	8d 76 00             	lea    0x0(%esi),%esi
                shmpgtable.shm_segs[shmid + i].shm_dtime = -1;
                shmpgtable.shm_segs[shmid + i].shm_ctime = -1;
                shmpgtable.shm_segs[shmid + i].shm_cpid = -1;
                shmpgtable.shm_segs[shmid + i].shm_lpid = -1;
                shmpgtable.shm_segs[shmid + i].shm_nattch = 0;
		kfree((char*)V2P(shmpgtable.shm_segs[shmid + i].pa));
801080c8:	8b 43 24             	mov    0x24(%ebx),%eax
801080cb:	83 ec 0c             	sub    $0xc,%esp
		shmpgtable.shm_segs[shmid + i].shm_perm.__key = -1;
801080ce:	c7 03 ff ff ff ff    	movl   $0xffffffff,(%ebx)
	for(int i = 0; i < reqPages; i++){
801080d4:	83 c7 01             	add    $0x1,%edi
		shmpgtable.shm_segs[shmid + i].shm_perm.mode = 0;
801080d7:	c7 43 04 00 00 00 00 	movl   $0x0,0x4(%ebx)
	for(int i = 0; i < reqPages; i++){
801080de:	83 c3 28             	add    $0x28,%ebx
		kfree((char*)V2P(shmpgtable.shm_segs[shmid + i].pa));
801080e1:	05 00 00 00 80       	add    $0x80000000,%eax
                shmpgtable.shm_segs[shmid + i].shm_segsz = 0;
801080e6:	c7 43 e0 00 00 00 00 	movl   $0x0,-0x20(%ebx)
                shmpgtable.shm_segs[shmid + i].shm_atime = -1;
801080ed:	c7 43 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebx)
                shmpgtable.shm_segs[shmid + i].shm_dtime = -1;
801080f4:	c7 43 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%ebx)
                shmpgtable.shm_segs[shmid + i].shm_ctime = -1;
801080fb:	c7 43 ec ff ff ff ff 	movl   $0xffffffff,-0x14(%ebx)
                shmpgtable.shm_segs[shmid + i].shm_cpid = -1;
80108102:	c7 43 f0 ff ff ff ff 	movl   $0xffffffff,-0x10(%ebx)
                shmpgtable.shm_segs[shmid + i].shm_lpid = -1;
80108109:	c7 43 f4 ff ff ff ff 	movl   $0xffffffff,-0xc(%ebx)
                shmpgtable.shm_segs[shmid + i].shm_nattch = 0;
80108110:	c7 43 f8 00 00 00 00 	movl   $0x0,-0x8(%ebx)
		kfree((char*)V2P(shmpgtable.shm_segs[shmid + i].pa));
80108117:	50                   	push   %eax
80108118:	e8 e3 a3 ff ff       	call   80102500 <kfree>
		shmpgtable.shm_segs[shmid + i].pa = 0;
8010811d:	c7 43 fc 00 00 00 00 	movl   $0x0,-0x4(%ebx)
	for(int i = 0; i < reqPages; i++){
80108124:	83 c4 10             	add    $0x10,%esp
80108127:	39 fe                	cmp    %edi,%esi
80108129:	75 9d                	jne    801080c8 <freeshmPages+0x28>
	}
}
8010812b:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010812e:	5b                   	pop    %ebx
8010812f:	5e                   	pop    %esi
80108130:	5f                   	pop    %edi
80108131:	5d                   	pop    %ebp
80108132:	c3                   	ret
80108133:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010813a:	00 
8010813b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80108140 <removeshmHelper>:

// Helper function for sys_removeshm
int removeshmHelper(int shm_identifier, int flag){
80108140:	55                   	push   %ebp
80108141:	89 e5                	mov    %esp,%ebp
80108143:	56                   	push   %esi
80108144:	53                   	push   %ebx
	int shmid = shm_identifier;
	int i = 0;
80108145:	31 db                	xor    %ebx,%ebx

	if(flag == 1){
80108147:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
int removeshmHelper(int shm_identifier, int flag){
8010814b:	8b 55 08             	mov    0x8(%ebp),%edx
		for(i = 0; i <= shmpgtable.lastShmSegIndex; i++){
8010814e:	a1 b4 34 13 80       	mov    0x801334b4,%eax
	if(flag == 1){
80108153:	0f 84 97 00 00 00    	je     801081f0 <removeshmHelper+0xb0>
				break;
			}
		}
	}

	if(i == (shmpgtable.lastShmSegIndex + 1) || shmid  == (shmpgtable.lastShmSegIndex + 1)){
80108159:	83 c0 01             	add    $0x1,%eax
8010815c:	39 d8                	cmp    %ebx,%eax
8010815e:	0f 84 d0 00 00 00    	je     80108234 <removeshmHelper+0xf4>
80108164:	39 d0                	cmp    %edx,%eax
80108166:	0f 84 c8 00 00 00    	je     80108234 <removeshmHelper+0xf4>
		cprintf("Invalid key or shmid!\n");
		return -1;
	}

	int reqPages = shmpgtable.shm_segs[shmid].shm_segsz / PGSIZE;
8010816c:	8d 1c 95 00 00 00 00 	lea    0x0(,%edx,4),%ebx
80108173:	8d 04 13             	lea    (%ebx,%edx,1),%eax
80108176:	8d 04 c5 80 b4 10 80 	lea    -0x7fef4b80(,%eax,8),%eax
	for (int i = 0; i < reqPages; i++){
8010817d:	8b 48 3c             	mov    0x3c(%eax),%ecx
80108180:	c1 e9 0c             	shr    $0xc,%ecx
80108183:	74 40                	je     801081c5 <removeshmHelper+0x85>
80108185:	01 d1                	add    %edx,%ecx
80108187:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
8010818a:	8d 0c cd 80 b4 10 80 	lea    -0x7fef4b80(,%ecx,8),%ecx
80108191:	89 ce                	mov    %ecx,%esi
80108193:	29 c6                	sub    %eax,%esi
80108195:	83 e6 08             	and    $0x8,%esi
80108198:	74 16                	je     801081b0 <removeshmHelper+0x70>
		shmpgtable.shm_segs[shmid + i].shm_perm.mode = SHM_DEST;
8010819a:	c7 40 38 20 00 00 00 	movl   $0x20,0x38(%eax)
	for (int i = 0; i < reqPages; i++){
801081a1:	83 c0 28             	add    $0x28,%eax
801081a4:	39 c8                	cmp    %ecx,%eax
801081a6:	74 1d                	je     801081c5 <removeshmHelper+0x85>
801081a8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801081af:	00 
		shmpgtable.shm_segs[shmid + i].shm_perm.mode = SHM_DEST;
801081b0:	c7 40 38 20 00 00 00 	movl   $0x20,0x38(%eax)
	for (int i = 0; i < reqPages; i++){
801081b7:	83 c0 50             	add    $0x50,%eax
		shmpgtable.shm_segs[shmid + i].shm_perm.mode = SHM_DEST;
801081ba:	c7 40 10 20 00 00 00 	movl   $0x20,0x10(%eax)
	for (int i = 0; i < reqPages; i++){
801081c1:	39 c8                	cmp    %ecx,%eax
801081c3:	75 eb                	jne    801081b0 <removeshmHelper+0x70>
	}

	if(shmpgtable.shm_segs[shmid].shm_nattch == 0 && (shmpgtable.shm_segs[shmid].shm_perm.mode & SHM_DEST)){
801081c5:	01 d3                	add    %edx,%ebx
801081c7:	8d 04 dd 80 b4 10 80 	lea    -0x7fef4b80(,%ebx,8),%eax
801081ce:	8b 48 54             	mov    0x54(%eax),%ecx
801081d1:	85 c9                	test   %ecx,%ecx
801081d3:	75 6f                	jne    80108244 <removeshmHelper+0x104>
801081d5:	f6 40 38 20          	testb  $0x20,0x38(%eax)
801081d9:	74 69                	je     80108244 <removeshmHelper+0x104>
		freeshmPages(shmid);
801081db:	83 ec 0c             	sub    $0xc,%esp
801081de:	52                   	push   %edx
801081df:	e8 bc fe ff ff       	call   801080a0 <freeshmPages>
	}
	else{
		return -1;
	}

	return 0;
801081e4:	83 c4 10             	add    $0x10,%esp
801081e7:	31 c0                	xor    %eax,%eax
}
801081e9:	8d 65 f8             	lea    -0x8(%ebp),%esp
801081ec:	5b                   	pop    %ebx
801081ed:	5e                   	pop    %esi
801081ee:	5d                   	pop    %ebp
801081ef:	c3                   	ret
		for(i = 0; i <= shmpgtable.lastShmSegIndex; i++){
801081f0:	85 c0                	test   %eax,%eax
801081f2:	79 17                	jns    8010820b <removeshmHelper+0xcb>
801081f4:	e9 60 ff ff ff       	jmp    80108159 <removeshmHelper+0x19>
801081f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80108200:	83 c3 01             	add    $0x1,%ebx
80108203:	39 c3                	cmp    %eax,%ebx
80108205:	0f 8f 4e ff ff ff    	jg     80108159 <removeshmHelper+0x19>
			if(shmpgtable.shm_segs[i].shm_perm.__key == shm_identifier){
8010820b:	8d 0c 9b             	lea    (%ebx,%ebx,4),%ecx
8010820e:	39 14 cd b4 b4 10 80 	cmp    %edx,-0x7fef4b4c(,%ecx,8)
80108215:	75 e9                	jne    80108200 <removeshmHelper+0xc0>
				cprintf("shmid: %d\n", shmid);
80108217:	83 ec 08             	sub    $0x8,%esp
8010821a:	53                   	push   %ebx
8010821b:	68 3f 88 10 80       	push   $0x8010883f
80108220:	e8 8b 84 ff ff       	call   801006b0 <cprintf>
	if(i == (shmpgtable.lastShmSegIndex + 1) || shmid  == (shmpgtable.lastShmSegIndex + 1)){
80108225:	a1 b4 34 13 80       	mov    0x801334b4,%eax
				break;
8010822a:	83 c4 10             	add    $0x10,%esp
				shmid = i;
8010822d:	89 da                	mov    %ebx,%edx
				break;
8010822f:	e9 25 ff ff ff       	jmp    80108159 <removeshmHelper+0x19>
		cprintf("Invalid key or shmid!\n");
80108234:	83 ec 0c             	sub    $0xc,%esp
80108237:	68 4a 88 10 80       	push   $0x8010884a
8010823c:	e8 6f 84 ff ff       	call   801006b0 <cprintf>
		return -1;
80108241:	83 c4 10             	add    $0x10,%esp
80108244:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80108249:	eb 9e                	jmp    801081e9 <removeshmHelper+0xa9>
