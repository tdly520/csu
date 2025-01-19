package android.bignerdranch.photogalleryactivity;

import androidx.fragment.app.Fragment;


public class PhotoActivity extends SingleFragmentActivity {

    @Override
    protected Fragment createFragment(){
        return PhotoFragment.newInstance();
    }

}