package com.example.backend.controller;

import com.example.backend.entity.Book;
import com.example.backend.entity.Copy;
import com.example.backend.service.CopyService;
import com.example.backend.service.impl.CopyServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;

@CrossOrigin(origins = "*")
@RestController
@RequestMapping(value="/copycrud",method = {RequestMethod.GET,RequestMethod.POST})
public class CopyCRUD {
    @Autowired
    private CopyServiceImpl copyService;

    @GetMapping("/listCopyByISBN")
    public List<Copy> ListCopyByISBN(@RequestParam("ISBN") String ISBN){
        return copyService.listCopiesByISBN(ISBN);
    }

    @PostMapping(value="delete")
    public String delete(@RequestParam("ISBN") String ISBN, @RequestParam("copy_ID") long copyID){
        int result = copyService.delete(ISBN, copyID);
        if (result >= 1){
            return "deleted";
        }else{
            return "failed to delete";
        }
    }

    @PostMapping(value = "insert")
    public Copy insert(@RequestParam("ISBN") String ISBN,
                       @RequestParam("copy_ID") long copyID,
                       @RequestParam("availability") Boolean availability,
                       @RequestParam("bookshelf_ID") long bookshelfID) {
        return copyService.insertCopy(ISBN, copyID, availability, bookshelfID);
    }

    @PostMapping(value = "update")
    public String update(@RequestParam("ISBN") String ISBN,
                         @RequestParam("copy_ID") long copyID,
                         @RequestParam("availability") Boolean availability,
                         @RequestParam("bookshelf_ID") long bookshelfID) {
        int result = copyService.update(ISBN, copyID, availability, bookshelfID);
        if (result >= 1){
            return "modified";
        }else{
            return "failed to modify";
        }
    }

    @PostMapping(value="BorrowBookWithKnownBook")
    public List<Boolean> borrowBookWithKnownBook(@RequestParam("ISBN") String ISBN,
                                                 @RequestParam("user_id") long userID){
        List<Boolean> result = new ArrayList<Boolean>();
        result.add(copyService.borrowBookWithKnownBook(ISBN, userID));
        return result;
    }

    @PostMapping(value="BorrowBookWithKnownCopy")
    public List<Boolean> borrowBookWithKnownCopy(@RequestParam("ISBN") String ISBN,
                                                 @RequestParam("copy_ID") long copyID,
                                                 @RequestParam("user_id") long userID){
        List<Boolean> result = new ArrayList<Boolean>();
        result.add(copyService.borrowBookWithKnownCopy(ISBN, copyID, userID));
        return result;
    }

    @PostMapping(value="ReturnBook")
    public int returnBook(@RequestParam("ISBN") String ISBN,
                          @RequestParam("copy_ID") long copyID,
                          @RequestParam("user_id") long userID){
        return copyService.returnBook(ISBN, copyID, userID);
    }
}
